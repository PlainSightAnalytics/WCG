<# 
Script:  UploadExecutionLog.ps1
Purpose: Uploads latest Execution Log rows to PaaS server and then refreshes the Power BI dataset via the API
Author:  Trevor Howe
Date:    24-06-2019
#>


# Exit if time between 12am and 6am
$Now = Get-Date 

if ($Now.Hour -lt 7 -or $Now.Hour -gt 21) {exit}


# Declare Common Variables
$schemaname = "model"
$executionlogkey = 0
$scriptname =  $script:MyInvocation.MyCommand.Path
$DeltaLogKey = 0
$LogKey = 0

Try 
{

    # Setup Source Connection Information
    $SourceConnectionString = "Server= $wcgserver ;Database= $wcgdwdb ;Integrated Security=True"
    $SourceConnection  = New-Object System.Data.SqlClient.SQLConnection
    $SourceConnection.ConnectionString = $SourceConnectionString 
    $SourceConnection.Open() 

    # Set SQL Command for Execution Log
    $sqlcmd = New-Object System.Data.SqlClient.SqlCommand
    $sqlcmd.Connection = $SourceConnection
    $sqlcmd.CommandType = [System.Data.CommandType]'StoredProcedure'

    # Create Execution Log
    $SqlCmd.CommandText = "WCG_Stage.dbo.prcInsertDimExecutionLog"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ScriptName",$ScriptName)
    $OutputParm = $SQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
    $OutputParm.Direction = 'Output'
    $SqlCmd.ExecuteNonQuery()
    $ExecutionLogKey = $OutputParm.Value

    # Setup Destination Connection Information
    
    # Connection on PSA Server
    $DestinationConnectionString = "Server=tcp:$pbiserver;Database=$pbidatabase;Uid=$pbiuserid;Pwd=$pbipwd;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"
    $DestinationConnection = New-Object System.Data.SqlClient.SqlConnection
    $DestinationConnection.ConnectionString = $DestinationConnectionString
    $DestinationConnection.Open()

    # Setup SQL Command for Source Select
    $SourceSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $SourceSQLCmd.Connection = $SourceConnection
    $SourceSQLCmd.CommandTimeout = 0

    # Get Last Completed Execution LogKey
    $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $DestinationSQLCmd.Connection = $DestinationConnection
    $DestinationSQLCmd.CommandText = "SELECT MAX(ExecutionlogKey) AS LastExecutionLogKey FROM model.[_Execution Log] WHERE ScriptEndTime IS NOT NULL"
    $DestinationSQLCmd.CommandTimeout = 0
    $Reader = $DestinationSQLCmd.ExecuteReader()
    while ($Reader.Read()) {
         $LastExecutionLogKey = $Reader.GetValue($1)
    }
    $Reader.Close()

    # Setup SQL Command for table delete
    $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $DestinationSQLCmd.Connection = $DestinationConnection
    $DestinationSQLCmd.CommandText = "DELETE FROM model.[_Execution Log] WHERE ExecutionLogKey > " + $LastExecutionLogKey
    $DestinationSQLCmd.CommandTimeout = 0
    $DestinationSQLCmd.ExecuteNonQuery()

    # SQL Command for table select
    $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
    $SourceSQLCmd.CommandText = "SELECT * FROM model.[_Execution Log] WHERE ExecutionLogKey > " + $LastExecutionLogKey

    # Get source data
    [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
    # Bulk copy to destination
    $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
    $bulkCopy.DestinationTableName = "[model].[_Execution Log]"
    $bulkcopy.BulkCopyTimeout = 0
    $bulkCopy.WriteToServer($SqlReader)
    $SqlReader.Close()

    # Refresh Dataset in app.powerbi.com
    Invoke-Expression ($ScriptFolder + "RefreshDatasetWCGExecutionLog.ps1")

}
Catch
{

    # Save Exception Details
    $ExceptionMessage = $_.Exception.Message.Trim()
    $ExceptionLine = $_.InvocationInfo.Line.Trim()
    $ExectptionLineNo = $_.InvocationInfo.ScriptLineNumber

    # Update Execution Log with Exception Details and Close
    $SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimExecutionLog"
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
    $SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimExecutionLog"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
    $SqlCmd.ExecuteNonQuery()

    $SourceConnection.Close()
    $DestinationConnection.Close()

}