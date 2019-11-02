<# 
Script:  LoadStageVehicleEnquiryResponsesLatest.ps1
Purpose: Loads VehicleEnquiryResponsesLatest for the last 48 hours from CLE
Author:  Trevor Howe
Date:    2019-03-06
#>

# Declare Variables
$pa_ScriptName =  $script:MyInvocation.MyCommand.Path
$pa_ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Common Variables
    $pa_auditkey = -1
    $pa_PreviousHighWaterMark = ""
    $pa_HighWaterMark = 0
    $pa_clientname = "WCG"
    $pa_schemaname = "cle"
    $pa_object = "VehicleEnquiryResponsesLatest"
    $pa_ExecutionLogKey = 0
    $pa_StageTable = "[" + $pa_schemaname + "].[" + $pa_object + "]"

    # Set SQL Connection and Command Objects
    $pa_DestinationConnection = New-Object System.Data.SqlClient.SqlConnection
    $pa_DestinationConnection.ConnectionString = "Server= $wcgserver ;Database= $wcgstagedb ;Integrated Security=True"
    $pa_DestinationConnection.Open()
    $pa_DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $pa_DestinationSQLCmd.Connection = $pa_DestinationConnection
    $pa_DestinationSQLCmd.CommandTimeout = 0
    $pa_DestinationSQLCmd.CommandType = [System.Data.CommandType]'StoredProcedure'

    # Create Execution Log
    $pa_DestinationSQLCmd.CommandText = "prcInsertDimExecutionLog"
    $pa_DestinationSQLCmd.Parameters.Clear()
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@ScriptName",$pa_ScriptName)
    $pa_OutputParm = $pa_DestinationSQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$pa_ExecutionLogKey)
    $pa_OutputParm.Direction = 'Output'
    $pa_DestinationSQLCmd.ExecuteNonQuery()
    $pa_ExecutionLogKey = $pa_OutputParm.Value

    # Create Audit row 
    $pa_DestinationSQLCmd.CommandText = "dbo.prcInsertDimAudit"
    $pa_DestinationSQLCmd.Parameters.Clear()
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@ClientName",$pa_clientname)
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@SchemaName",$pa_schemaname)
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@TableName",$pa_object)
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@ScriptName",$pa_ScriptName)
    $pa_OutputParm = $pa_DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$pa_auditkey)
    $pa_OutputParm.Direction = 'Output'
    $pa_DestinationSQLCmd.ExecuteNonQuery()
    $pa_auditkey = $pa_OutputParm.Value
    
    # Get last Record Id from DeltaLog
    $pa_DestinationSQLCmd.CommandText ="cle.prcLoadVehicleEnquiryResponsesLatest"
    $pa_DestinationSQLCmd.Parameters.Clear()
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@DaysPrevious",2)
    $pa_OutputParm = $pa_DestinationSQLCmd.Parameters.AddWithValue("@LastVehicleEnquiryResponsesRecordId",$pa_PreviousHighWaterMark)
    $pa_OutputParm.Direction = 'Output'
    $pa_OutputParm.DbType = [System.Data.DbType]'String';
    $pa_OutputParm.Size = 20
    $pa_DestinationSQLCmd.ExecuteNonQuery()
    $pa_PreviousHighWaterMark = $pa_OutputParm.Value
    $pa_DestinationSQLCmd.Parameters.Clear()

    # Get Latest Record Id and Count from CLE
    $pa_SrcConnStr = “Data Source=" + $sourceserver + ";Initial Catalog=" + $sourcedatabase + ";Integrated Security=False;user=" + $sourceuserid + ";pwd=" + $sourcepwd + ";Timeout = 0;"    
    #$pa_SrcConnStr = “Data Source=" + $wcgserver + ";Initial Catalog=" + $sourcedatabase + ";Integrated Security=True;Timeout = 0;"    
    $pa_SourceConnection  = New-Object System.Data.SqlClient.SQLConnection
    $pa_SourceConnection.ConnectionString = $pa_SrcConnStr 
    $pa_SourceConnection.Open()

    $pa_SourceSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $pa_SourceSQLCmd.Connection = $pa_SourceConnection
    $pa_SourceSQLCmd.CommandTimeout = 0
    $pa_SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
    $pa_SourceSQLCmd.CommandText = "SELECT " 
	$pa_SourceSQLCmd.CommandText += " VehicleEnquiryResponseRecordId,Timestamp,LicenceNumber,VehicleUsageCode,CategoryCode"
    $pa_SourceSQLCmd.CommandText += " FROM VehicleEnquiryResponses WITH (NOLOCK) WHERE VehicleEnquiryResponseRecordId > " + $pa_PreviousHighWaterMark
    $pa_SourceSQLCmd.CommandTimeout = 0 

    [System.Data.SqlClient.SqlDataReader] $pa_SqlReader = $pa_SourceSQLCmd.ExecuteReader()
    
    $pa_bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($pa_DestinationConnection.ConnectionString, [System.Data.SqlClient.SqlBulkCopyOptions]::KeepIdentity)
    $pa_bulkCopy.DestinationTableName = $pa_schemaname + ".VehicleEnquiryResponsesLatest"
    $pa_bulkcopy.BulkCopyTimeout = 0
    $pa_bulkCopy.WriteToServer($pa_SqlReader)

    # Update Audit row
    $pa_DestinationSQLCmd.CommandText = "dbo.prcUpdateDimAudit"
    $pa_DestinationSQLCmd.Parameters.Clear()
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$pa_AuditKey)
    $pa_DestinationSQLCmd.ExecuteNonQuery()

}
Catch
{

    # Save Exception Details
    $pa_ExceptionMessage = $_.Exception.Message.Trim()
    $pa_ExceptionLine = $_.InvocationInfo.Line.Trim()
    $pa_ExectptionLineNo = $_.InvocationInfo.ScriptLineNumber

    # Update Execution Log with Exception Details and Close
    $pa_DestinationSQLCmd.CommandText = "prcUpdateDimExecutionLog"
    $pa_DestinationSQLCmd.Parameters.Clear()
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$pa_ExecutionLogKey)
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@ExceptionLineNo",$pa_ExectptionLineNo)
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@ExceptionLine",$pa_ExceptionLine)
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@ExceptionMessage",$pa_ExceptionMessage)
    $pa_DestinationSQLCmd.ExecuteNonQuery()

}
Finally
{

    # Close off Execution Log
    $pa_DestinationSQLCmd.CommandText = "prcUpdateDimExecutionLog"
    $pa_DestinationSQLCmd.Parameters.Clear()
    $pa_DestinationSQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$pa_ExecutionLogKey)
    $pa_DestinationSQLCmd.ExecuteNonQuery()

    $pa_DestinationConnection.Close()

}