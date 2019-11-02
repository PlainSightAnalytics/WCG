<# 
Script:  UploadModelData.ps1
Purpose: Uploads model data to Model Server and Database
Author:  Trevor Howe
Date:    22-04-2018
#>


# Declare Common Variables
$schemaname = "model"
$clientname = "WCG"
$executionlogkey = 0
$scriptname =  $script:MyInvocation.MyCommand.Path

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
    $DestinationConnectionString = "Server=tcp:$psaserver;Database=$psadatabase;Uid=$psauser;Pwd=$psapassword;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"
    $DestinationConnection = New-Object System.Data.SqlClient.SqlConnection
    $DestinationConnection.ConnectionString = $DestinationConnectionString
    $DestinationConnection.Open()

    # Setup SQL Command for Source Select
    $SourceSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $SourceSQLCmd.Connection = $SourceConnection

    # Download AuditLog

        # Setup SQL Command for table delete
        $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $DestinationSQLCmd.Connection = $DestinationConnection
        $DestinationSQLCmd.CommandText = "SELECT ISNULL(MAX(AuditLogKey),0) FROM [model].[AuditLog] WHERE ClientName = '" + $clientname + "'"
        $auditlogkey = $DestinationSQLCmd.ExecuteScalar()


        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [model].[AuditLog] WHERE AuditLogKey > " + $auditlogkey

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        
        $bulkCopy.DestinationTableName = "[model].[AuditLog]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()

    # Download DeltaLog

        # Setup SQL Command for table delete
        $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $DestinationSQLCmd.Connection = $DestinationConnection
        $DestinationSQLCmd.CommandText = "SELECT ISNULL(MAX(DeltaLogKey),0) FROM [model].[DeltaLog] WHERE ClientName = '" + $clientname + "'"
        $deltalogkey = $DestinationSQLCmd.ExecuteScalar()


        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [model].[DeltaLog] WHERE DeltaLogKey > " + $deltalogkey

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        
        $bulkCopy.DestinationTableName = "[model].[DeltaLog]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()

    # Download ExecutionLog

        # Setup SQL Command for table delete
        $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $DestinationSQLCmd.Connection = $DestinationConnection
        $DestinationSQLCmd.CommandText = "SELECT ISNULL(MAX(ExecutionLogKey),0) FROM [model].[ExecutionLog] WHERE ClientName = '" + $clientname + "'"
        $executionlogkeymax = $DestinationSQLCmd.ExecuteScalar()


        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [model].[ExecutionLog] WHERE ExecutionLogKey > " + $executionlogkeymax + " AND ExecutionLogKey < " + $executionlogkey

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        
        $bulkCopy.DestinationTableName = "[model].[ExecutionLog]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()

    #Download Log Date

        # Setup SQL Command for table delete
        $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $DestinationSQLCmd.Connection = $DestinationConnection
        $DestinationSQLCmd.CommandText = "TRUNCATE TABLE model.LogDate"
        $DestinationSQLCmd.ExecuteNonQuery()


        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [model].[LogDate] OPTION (MAXRECURSION 0)"

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        
        $bulkCopy.DestinationTableName = "[model].[LogDate]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()

}
Catch
{

    # Save Exception Details
    $exceptionmessage = $_.Exception.Message.Trim()
    $exceptionline = $_.InvocationInfo.Line.Trim()
    $exectptionlineno = $_.InvocationInfo.ScriptLineNumber

    # Update Execution Log with Exception Details and Close
    $sqlcmd.CommandText = "WCG_Stage.dbo.prcUpdateDimExecutionLog"
    $sqlcmd.Parameters.Clear()
    $sqlcmd.Parameters.AddWithValue("@ExecutionLogKey",$executionlogkey)
    $sqlcmd.Parameters.AddWithValue("@ExceptionLineNo",$exectptionlineno)
    $sqlcmd.Parameters.AddWithValue("@ExceptionLine",$exceptionline)
    $sqlcmd.Parameters.AddWithValue("@ExceptionMessage",$exceptionmessage)
    $sqlcmd.ExecuteNonQuery()

}
Finally
{

    # Close off Execution Log
    $sqlcmd.CommandText = "WCG_Stage.dbo.prcUpdateDimExecutionLog"
    $sqlcmd.Parameters.Clear()
    $sqlcmd.Parameters.AddWithValue("@ExecutionLogKey",$executionlogkey)
    $sqlcmd.ExecuteNonQuery()

    $SourceConnection.Close()
    $DestinationConnection.Close()

}



