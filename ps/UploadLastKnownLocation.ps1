<# 
Script:  UploadModelData.ps1
Purpose: Uploads model data to Model Server and Database
Author:  Trevor Howe
Date:    17-03-2017
#>


# Declare Common Variables
$lkn_schemaname = "model"
$lkn_executionlogkey = 0
$lkn_scriptname =  $script:MyInvocation.MyCommand.Path
$lkn_DeltaLogKey = 0

Try 
{

    # Setup Source Connection Information
    $lkn_SourceConnectionString = "Server= $wcgserver ;Database= $wcgdwdb ;Integrated Security=True"
    $lkn_SourceConnection  = New-Object System.Data.SqlClient.SQLConnection
    $lkn_SourceConnection.ConnectionString = $lkn_SourceConnectionString 
    $lkn_SourceConnection.Open() 

    # Set SQL Command for Execution Log
    $lkn_sqlcmd = New-Object System.Data.SqlClient.SqlCommand
    $lkn_sqlcmd.Connection = $lkn_SourceConnection
    $lkn_sqlcmd.CommandType = [System.Data.CommandType]'StoredProcedure'


    # Create Execution Log
    $lkn_SqlCmd.CommandText = "WCG_Stage.dbo.prcInsertDimExecutionLog"
    $lkn_SqlCmd.Parameters.Clear()
    $lkn_SqlCmd.Parameters.AddWithValue("@ScriptName",$lkn_ScriptName)
    $lkn_OutputParm = $lkn_SQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$lkn_ExecutionLogKey)
    $lkn_OutputParm.Direction = 'Output'
    $lkn_SqlCmd.ExecuteNonQuery()
    $lkn_ExecutionLogKey = $lkn_OutputParm.Value

    # Setup Destination Connection Information
    
    # Connection on PSA Server
    $lkn_DestinationConnectionString = "Server=tcp:$pbiserver;Database=$pbidatabase;Uid=$pbiuserid;Pwd=$pbipwd;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"
    $lkn_DestinationConnection = New-Object System.Data.SqlClient.SqlConnection
    $lkn_DestinationConnection.ConnectionString = $lkn_DestinationConnectionString
    $lkn_DestinationConnection.Open()

    # Setup SQL Command for Source Select
    $lkn_SourceSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $lkn_SourceSQLCmd.Connection = $lkn_SourceConnection
    $lkn_SourceSQLCmd.CommandTimeout = 0

    # Declare model tables to be copied - flush and load
    $lkn_modeltables = @(
                     "Last Known Location"
                     ,"Last Known Location Shift Tasks"
                     ,"Last Known Location Shift"
                   )

    foreach ($lkn_modeltable in $lkn_modeltables) {

        # Setup SQL Command for table delete
        $lkn_DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $lkn_DestinationSQLCmd.Connection = $lkn_DestinationConnection
        $lkn_DestinationSQLCmd.CommandText = "DELETE FROM [" + $lkn_schemaname + "].[" + $lkn_modeltable + "]"
        $lkn_DestinationSQLCmd.CommandTimeout = 0
        $lkn_DestinationSQLCmd.ExecuteNonQuery()

        # SQL Command for table select
        $lkn_SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $lkn_SourceSQLCmd.CommandText = "SELECT * FROM [" + $lkn_schemaname + "].[" + $lkn_modeltable + "]"

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $lkn_SqlReader = $lkn_SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $lkn_bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($lkn_DestinationConnection)
        
        $lkn_bulkCopy.DestinationTableName = "[" + $lkn_schemaname + "].[" + $lkn_modeltable + "]"
        $lkn_bulkcopy.BulkCopyTimeout = 0
        $lkn_bulkCopy.WriteToServer($lkn_SqlReader)
        $lkn_SqlReader.Close()

    }

}
Catch
{

    # Save Exception Details
    $lkn_ExceptionMessage = $_.Exception.Message.Trim()
    $lkn_ExceptionLine = $_.InvocationInfo.Line.Trim()
    $lkn_ExectptionLineNo = $_.InvocationInfo.ScriptLineNumber

    # Update Execution Log with Exception Details and Close
    $lkn_SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimExecutionLog"
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
    $lkn_SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimExecutionLog"
    $lkn_SqlCmd.Parameters.Clear()
    $lkn_SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$lkn_ExecutionLogKey)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionLineNo",$lkn_ExectptionLineNo)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionLine",$lkn_ExceptionLine)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionMessage",$lkn_ExceptionMessage)
    $lkn_SqlCmd.ExecuteNonQuery()


    $lkn_SourceConnection.Close()
    $lkn_DestinationConnection.Close()

}