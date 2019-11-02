<# 
Script:  LoadStageImpoundNonDeltaTables.ps1
Purpose: Loads Impound Non Delta Tables from JSON data
Author:  Trevor Howe
Date:    02-02-2019
#>

$ScriptName =  $script:MyInvocation.MyCommand.Path

Try 
{

    # Declare Common Variables
    $objecttype='json'
    $folder = $wcgroot + "data\"                    
    $archivefolder = $wcgroot + "archive\"
    $rowcountsource = 0 
    $auditkey = -1
    $HighWaterDateTime = [string] "1900-01-01T00:00:00Z"
    $clientname = "WCG"
    $schemaname = "pnd"
    $BaseURI = 'https://run-eu.journeyapps.com/api/v4'
    $username = $impounduser
    $password = $impoundpassword
    $rowupdated = 0
    $ExecutionLogKey = 0
    $DeltaLogKey = 0
    $TruncateFlag = 1

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

    # Declare array of object names (corresponds to stage table, Insert Stored Procedure must already exist)
    $objects = @(
         "impound"
        ,"local_municipality"
        ,"traffic_centre"
        ,"user"
    )

    foreach ($object in $objects) {

        # Build authentication
        $auth = 'Basic ' + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($username+":"+$password ))
        $req = New-Object  System.Net.WebClient
        $req.Headers.Add('Content-Type', 'application/json')
        $req.Headers.Add('Accept', 'application/json')
        $req.Headers.Add('Authorization', $auth )

        # Build Latest Update uri
        $lastupdatedateuri = "$BaseURI/$username/objects/$object.$objecttype`?sort[_updated_at]=desc&limit=1"
        $result = $req.DownloadString($lastupdatedateuri)
        $converted = ConvertFrom-Json $result
        $highwaterdatetime = $converted.objects.updated_at
        $rowcountsource = $converted.total

        # Check High Water Mark
        $SqlCmd.CommandText = "dbo.prcUpdateHighWaterMark"
        $SqlCmd.Connection = $SqlConnection
        $SqlCmd.CommandType = [System.Data.CommandType]'StoredProcedure'
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
        $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
        $SqlCmd.Parameters.AddWithValue("@ObjectName",$object)
        $SqlCmd.Parameters.AddWithValue("@HighWaterDateTime",$highwaterdatetime)
        $SqlCmd.Parameters.AddWithValue("@RowCountSource",$rowcountsource)
        $OutputParm1 = $SqlCmd.Parameters.AddWithValue("@RowUpdated",$rowupdated)
        $OutputParm1.Direction = 'Output'
        $OutputParm2 = $SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
        $OutputParm2.Direction = 'Output'
        $SqlCmd.ExecuteNonQuery()
        $rowupdated = $OutputParm1.Value
        $DeltaLogKey = $OutputParm2.Value

        # Only do the load if the last update date has changed
        If ($rowupdated -eq 1) 
        {

            $StageTable = "[" + $schemaname + "].[" + $object + "]"
            $i = 0
            $TruncateFlag = 1

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

            # Build Count uri
            $counturi = "$BaseURI/$username/objects/$object/count.$objecttype"
    
            # Get Count
            $result = $req.DownloadString($counturi)
            $converted = ConvertFrom-Json $result
            $rowcountsource = $converted.count

            if ($rowcountsource -gt 0) {

                # Divide data into batches and output to file
                $waitseconds =5
                $limit = 1000
                $datauri = "$BaseURI/$username/objects/$object.$objecttype"

                $loopcounter = [Math]::Ceiling($rowcountsource / $limit)

                for ($i=0; $i -lt $loopcounter; $i++) {
                    $skip = $i * $limit
                    $datasubseturi = $datauri + "`?limit=" + $limit + "&skip=" + $skip
                    $incrementname = (get-date).ToString("yyyyMMddhhssms")
                    $subfilename = $folder + $object + "_"  + $incrementname + "." + $objecttype
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
                    $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
                    $SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
                    $SqlCmd.Parameters.AddWithValue("@TruncateFlag",$TruncateFlag)
                    $SqlCmd.ExecuteNonQuery()
                    $TruncateFlag = 0

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
            }
        }

        # Update Audit row
        $SqlCmd.CommandText = "dbo.prcUpdateDimAudit"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
        $SqlCmd.ExecuteNonQuery()

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
