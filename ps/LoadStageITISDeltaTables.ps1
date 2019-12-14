<# 
Script:  LoadStageTables.ps1
Purpose: Loads multiple Stage tables from JSON data
Author:  Trevor Howe
Date:    16 June 2016
#>

$ScriptName =  $script:MyInvocation.MyCommand.Path

Try 
{

    # Declare Common Variables
    $objecttype='json'
    $folder = $wcgroot + "data\"                    
    $archivefolder = $wcgroot + "archive\"
    $rowcountstagedelta = 0
    $rowcountstage = 0 
    $deltalogkey = 1
    $previousdeltalogkey = 0
    $auditkey = -1
    $HighWaterDateTime = [datetime] "1900-01-01T00:00:00Z"
    $clientname = "WCG"
    $schemaname = "itis"
    $BaseURI = 'https://run.journeyapps.com/api/v4'
    $username = $itisuser
    $password = $itispassword
    $object = "event"
    $ExecutionLogKey = 0
    
    # Set SQL Connection and Command Objects
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = "Server= $wcgserver ;Database= $wcgstagedb ;Integrated Security=True"
    $SqlConnection.Open()
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.Connection = $SqlConnection
    $SqlCmd.CommandType = [System.Data.CommandType]'StoredProcedure'

    # Create Execution Log
    $SqlCmd.CommandText = "prcInsertDimExecutionLog"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ScriptName",$ScriptName)
    $OutputParm = $SQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
    $OutputParm.Direction = 'Output'
    $SqlCmd.ExecuteNonQuery()
    $ExecutionLogKey = $OutputParm.Value

    # Build authentication
    $auth = 'Basic ' + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($username+":"+$password ))
    $req = New-Object  System.Net.WebClient
    $req.Headers.Add('Content-Type', 'application/json')
    $req.Headers.Add('Accept', 'application/json')
    $req.Headers.Add('Authorization', $auth )

    # Declare array of object names (corresponds to stage table, Insert Stored Procedure must already exist
    $objects = @(
         #"alert",
         "activity"
        ,"app_actual"
        ,"critical_outcome"
        ,"driver"
        ,"event"
        ,"event_road_safety_topic"
        ,"impound_request"
        ,"last_known_location"
        ,"officials_involved_in_operation"
        ,"operation"
        ,"section56_form"
        ,"shift"
        ,"shift_statistic"
        ,"shift_week"
        ,"task"
        ,"vehicle"
        ,"violation_charge"
    )

    foreach ($object in $objects) {

        # Build Latest Update uri
        $lastupdatedateuri = "$BaseURI/$username/objects/$object.$objecttype`?sort[_updated_at]=desc&limit=1"
        $result = $req.DownloadString($lastupdatedateuri)
        $converted = ConvertFrom-Json $result
        $highwaterdatetime = $converted.objects.updated_at
        $rowcountsource = $converted.total

        $StageTable = "[" + $schemaname + "].[" + $object + "]"
        $i = 0
        $TruncateFlag = 0

        # Get last update date
        $SqlCmd.CommandText = "dbo.prcGetHighWaterDateTime"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
        $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
        $SqlCmd.Parameters.AddWithValue("@ObjectName",$object)
        $OutputParm = $SqlCmd.Parameters.AddWithValue("@HighWaterDateTime",$HighWaterDateTime)
        $OutputParm.Direction = 'Output'
        $OutputParm.DbType = [System.Data.DbType]'datetime';
        $OutputParm.Size = 20
        $SqlCmd.ExecuteNonQuery()
        $HighWaterDateTime = $OutputParm.Value
        $HighwaterDateTimeString = $HighWaterDateTime.AddSeconds(1).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        $HighwaterDateTimeString = $HighWaterDateTime.AddSeconds(1).ToString("yyyy-MM-ddTHH:mm:ssZ")

        # Create additional search parameters based on object
        $additionalsearchfilter = ""
        if ($object -eq "alert")
        {
            $additionalsearchfilter = "&q[event_id.null]=false"
        }

        # Build Count uri
        $counturi = "$BaseURI/$username/objects/$object/count.$objecttype`?q[_updated_at.gt]=$HighWaterDateTimeString$additionalsearchfilter"
    
        # Get Count
        $result = $req.DownloadString($counturi)
        $converted = ConvertFrom-Json $result
        $rowcountsource = $converted.count
    
        if ($rowcountsource -gt 0) {

            # Create Audit row 
            $SqlCmd.CommandText = "dbo.prcInsertDimAudit"
            $SqlCmd.Parameters.Clear()
            $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
            $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
            $SqlCmd.Parameters.AddWithValue("@TableName",$object)
            $SqlCmd.Parameters.AddWithValue("@ScriptName",$scriptname)
            $OutputParm = $SqlCmd.Parameters.AddWithValue("@AuditKey",$auditkey)
            $OutputParm.Direction = 'Output'
            $SqlCmd.ExecuteNonQuery()
            $auditkey = $OutputParm.Value            
        
            # Insert Delta Log
            $SqlCmd.CommandText = "dbo.prcInsertDimDeltaLog"
            $SqlCmd.Parameters.Clear()
            $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
            $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
            $SqlCmd.Parameters.AddWithValue("@ObjectName",$object)
            $SqlCmd.Parameters.AddWithValue("@RowCountSource",$rowcountsource)
            $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
            $OutputParm = $SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
            $OutputParm.Direction = 'Output'
            $OutputParm.DbType = [System.Data.DbType]'String';
            $OutputParm.Size = 20
            $SqlCmd.ExecuteNonQuery()
            $DeltaLogKey = $OutputParm.Value

            # Divide data into batches and output to file
            $waitseconds =5
            $limit = 1000
            $datauri = "$BaseURI/$username/objects/$object.$objecttype`?sort[`$natural]=1&q[_updated_at.gt]=$HighWaterDateTimeString$additionalsearchfilter"
            
            $loopcounter = [Math]::Ceiling($rowcountsource / $limit)

            for ($i=0; $i -lt $loopcounter; $i++) {
                $skip = $i * $limit
                $datasubseturi = $datauri + "&limit=" + $limit + "&skip=" + $skip
                $deltaname = $DeltaLogKey.PadLeft(10,'0')
                $incrementname = ($i+1).ToString().PadLeft(10,'0')
                $subfilename = $folder + $object + "_" + $deltaname + "_" + $incrementname + "." + $objecttype
                $result = $req.DownloadFile($datasubseturi,$subfilename)
                Start-Sleep -s $waitseconds
            }
    
            # Check folder to see if there are any files
            $files = get-childitem -path $folder -filter $object"*.json" | sort-object -property name -descending
            foreach ($file in $files){
    
                $fullfilename = $file.FullName

                $SqlCmd.CommandText = $schemaname + ".prcExtract" + $object
                $SqlCmd.Parameters.Clear()
                $SqlCmd.Parameters.AddWithValue("@FileName",$FullFileName)
                $SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
                $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
                $SqlCmd.Parameters.AddWithValue("@TruncateFlag",$TruncateFlag)
                $SqlCmd.ExecuteNonQuery()

                # Archive Json File
                $ZipFile = $archivefolder + $object + ".zip"

                #Zip Files
                Add-Type -assembly "system.io.compression.filesystem"
                $zip =  [System.IO.Compression.ZipFile]::Open($ZipFile,"Update")
                [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $fullfilename,$file.name,"optimal")
                $zip.Dispose()

                #Delete Files
                $file.Delete()

            }

            # Update Delta Log Row
            $SqlCmd.CommandText = "dbo.prcUpdateDimDeltaLog" 
            $SqlCmd.Parameters.Clear()
            $SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
            $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
            $SqlCmd.Parameters.AddWithValue("@StageTable",$StageTable)
            $SqlCmd.ExecuteNonQuery()

            # Update Audit row
            $SqlCmd.CommandText = "dbo.prcUpdateDimAudit"
            $SqlCmd.Parameters.Clear()
            $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
            $SqlCmd.ExecuteNonQuery()
        }

    }

}
Catch
{

    # Save Exception Details
    $ExceptionMessage = $_.Exception.Message.Trim()
    $ExceptionLine = $_.InvocationInfo.Line.Trim()
    $ExectptionLineNo = $_.InvocationInfo.ScriptLineNumber

    # Update Execution Log with Exception Details and Close
    $SqlCmd.CommandText = "prcUpdateDimExecutionLog"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
    $SqlCmd.Parameters.AddWithValue("@ExceptionLineNo",$ExectptionLineNo)
    $SqlCmd.Parameters.AddWithValue("@ExceptionLine",$ExceptionLine)
    $SqlCmd.Parameters.AddWithValue("@ExceptionMessage",$ExceptionMessage)
    $SqlCmd.ExecuteNonQuery()

}
Finally
{

    # Close off Execution Log
    $SqlCmd.CommandText = "prcUpdateDimExecutionLog"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
    $SqlCmd.ExecuteNonQuery()

    $SqlConnection.Close()

}

