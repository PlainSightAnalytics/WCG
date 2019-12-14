<# 
Script:  LoadStageTables.ps1
Purpose: Loads multiple Stage tables from JSON data
Author:  Trevor Howe
Date:    16 June 2016
#>

$lkn_ScriptName =  $script:MyInvocation.MyCommand.Path

Try 
{

    # Declare Common Variables
    $lkn_objecttype='json'
    $lkn_folder = $wcgroot + "data\"                    
    $lkn_archivefolder = $wcgroot + "archive\"
    $lkn_rowcountstagedelta = 0
    $lkn_rowcountstage = 0 
    $lkn_deltalogkey = 1
    $lkn_previousdeltalogkey = 0
    $lkn_auditkey = -1
    $lkn_HighWaterDateTime = [datetime] "1900-01-01T00:00:00Z"
    $lkn_clientname = "WCG"
    $lkn_schemaname = "itis"
    $lkn_BaseURI = 'https://run.journeyapps.com/api/v4'
    $lkn_username = $itisuser
    $lkn_password = $itispassword
    $lkn_object = "last_known_location_current"
    $lkn_journey_table = "last_known_location"
    $lkn_ExecutionLogKey = 0
    
    # Set SQL Connection and Command Objects
    $lkn_SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $lkn_SqlConnection.ConnectionString = "Server= $wcgserver ;Database= $wcgstagedb ;Integrated Security=True"
    $lkn_SqlConnection.Open()
    $lkn_SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $lkn_SqlCmd.Connection = $lkn_SqlConnection
    $lkn_SqlCmd.CommandType = [System.Data.CommandType]'StoredProcedure'


    # Create Execution Log
    $lkn_SqlCmd.CommandText = "prcInsertDimExecutionLog"
    $lkn_SqlCmd.Parameters.Clear()
    $lkn_SqlCmd.Parameters.AddWithValue("@ScriptName",$lkn_ScriptName)
    $lkn_OutputParm = $lkn_SQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$lkn_ExecutionLogKey)
    $lkn_OutputParm.Direction = 'Output'
    $lkn_SqlCmd.ExecuteNonQuery()
    $lkn_ExecutionLogKey = $lkn_OutputParm.Value

    # Build authentication
    $lkn_auth = 'Basic ' + [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($lkn_username+":"+$lkn_password ))
    $lkn_req = New-Object  System.Net.WebClient
    $lkn_req.Headers.Add('Content-Type', 'application/json')
    $lkn_req.Headers.Add('Accept', 'application/json')
    $lkn_req.Headers.Add('Authorization', $lkn_auth )
  
    $lkn_StageTable = "[" + $lkn_schemaname + "].[" + $lkn_object + "]"
    $lkn_i = 0
    $lkn_TruncateFlag = 0

    # Get last update date
    $lkn_SqlCmd.CommandText = "dbo.prcGetHighWaterDateTimeLastKnownLocation"
    $lkn_SqlCmd.Parameters.Clear()
    $lkn_OutputParm = $lkn_SqlCmd.Parameters.AddWithValue("@HighWaterDateTime",$lkn_HighWaterDateTime)
    $lkn_OutputParm.Direction = 'Output'
    $lkn_OutputParm.DbType = [System.Data.DbType]'datetime';
    $lkn_OutputParm.Size = 20
    $lkn_SqlCmd.ExecuteNonQuery()
    $lkn_HighWaterDateTime = $lkn_OutputParm.Value
    $lkn_HighwaterDateTimeString = $lkn_HighWaterDateTime.AddSeconds(1).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
    $lkn_HighwaterDateTimeString = $lkn_HighWaterDateTime.AddSeconds(1).ToString("yyyy-MM-ddTHH:mm:ssZ")
    $lkn_deltaname = $lkn_HighWaterDateTime.ToString("yyyyMMddHHmm")

    # Build Count uri
    $lkn_counturi = "$lkn_BaseURI/$lkn_username/objects/$lkn_journey_table/count.$lkn_objecttype`?q[_updated_at.gt]=$lkn_HighWaterDateTimeString"
    
    # Get Count
    $lkn_result = $lkn_req.DownloadString($lkn_counturi)
    $lkn_converted = ConvertFrom-Json $lkn_result
    $lkn_rowcountsource = $lkn_converted.count


    # Divide data into batches and output to file
    $lkn_waitseconds =5
    $lkn_limit = 1000
    $lkn_datauri = "$lkn_BaseURI/$lkn_username/objects/$lkn_journey_table.$lkn_objecttype`?sort[`$natural]=1&q[_updated_at.gt]=$lkn_HighWaterDateTimeString"
            
    $lkn_loopcounter = [Math]::Ceiling($lkn_rowcountsource / $lkn_limit)

    for ($lkn_i=0; $lkn_i -lt $lkn_loopcounter; $lkn_i++) {
        $lkn_skip = $lkn_i * $lkn_limit
        $lkn_datasubseturi = $lkn_datauri + "&limit=" + $lkn_limit + "&skip=" + $lkn_skip
        $lkn_incrementname = ($lkn_i+1).ToString().PadLeft(10,'0')
        $lkn_subfilename = $lkn_folder + $lkn_object + "_" + $lkn_deltaname + "_" + $lkn_incrementname + "." + $lkn_objecttype
        $lkn_result = $lkn_req.DownloadFile($lkn_datasubseturi,$lkn_subfilename)
        Start-Sleep -s $lkn_waitseconds
    }
    
    # Check folder to see if there are any files
    $lkn_files = get-childitem -path $lkn_folder -filter $lkn_object"*.json" | sort-object -property name -descending
    foreach ($lkn_file in $lkn_files){
    
        $lkn_fullfilename = $lkn_file.FullName

        $lkn_SqlCmd.CommandText = $lkn_schemaname + ".prcExtract" + $lkn_object
        $lkn_SqlCmd.Parameters.Clear()
        $lkn_SqlCmd.Parameters.AddWithValue("@FileName",$lkn_FullFileName)
        $lkn_SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$lkn_DeltaLogKey)
        $lkn_SqlCmd.Parameters.AddWithValue("@AuditKey",$lkn_AuditKey)
        $lkn_SqlCmd.Parameters.AddWithValue("@TruncateFlag",$lkn_TruncateFlag)
        $lkn_SqlCmd.ExecuteNonQuery()

        #Delete Files
        $lkn_file.Delete()

    }

}
Catch
{

    # Save Exception Details
    $lkn_ExceptionMessage = $_.Exception.Message.Trim()
    $lkn_ExceptionLine = $_.InvocationInfo.Line.Trim()
    $lkn_ExectptionLineNo = $_.InvocationInfo.ScriptLineNumber


    # Update Execution Log with Exception Details and Close
    $lkn_SqlCmd.CommandText = "prcUpdateDimExecutionLog"
    $lkn_SqlCmd.Parameters.Clear()
    $lkn_SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$lkn_ExecutionLogKey)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionLineNo",$lkn_ExectptionLineNo)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionLine",$lkn_ExceptionLine)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionMessage",$lkn_ExceptionMessage)
    $lkn_SqlCmd.ExecuteNonQuery()

}
Finally
{

    # Update Execution Log with Exception Details and Close
    $lkn_SqlCmd.CommandText = "prcUpdateDimExecutionLog"
    $lkn_SqlCmd.Parameters.Clear()
    $lkn_SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$lkn_ExecutionLogKey)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionLineNo",$lkn_ExectptionLineNo)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionLine",$lkn_ExceptionLine)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionMessage",$lkn_ExceptionMessage)
    $lkn_SqlCmd.ExecuteNonQuery()

    $lkn_SqlConnection.Close()

}

