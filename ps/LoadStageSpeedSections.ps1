<# 
Script:  LoadStageSpeedSections.ps1
Purpose: Loads SpeedSections table from CLE Data
Author:  Trevor Howe
Date:    3 August 2016
#>

# Declare Variables
$ScriptName =  $script:MyInvocation.MyCommand.Path
$ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Variables
    $object = "SpeedSections"
    $clientname = "WCG"
    $schemaname = "cle"
    $auditkey = -1
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

    # Create Audit row 
    $SqlCmd.CommandText = "dbo.prcInsertDimAudit"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
    $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
    $SqlCmd.Parameters.AddWithValue("@TableName",$TableName)
    $SqlCmd.Parameters.AddWithValue("@ScriptName",$ScriptName)
    $OutputParm = $SqlCmd.Parameters.AddWithValue("@AuditKey",$auditkey)
    $OutputParm.Direction = 'Output'
    $SqlCmd.ExecuteNonQuery()
    $auditkey = $OutputParm.Value

    # Setup Source Connection Parameters
    $SrcConnStr = “Data Source=" + $sourceserver + ";Initial Catalog=" + $sourcedatabase + ";Integrated Security=False;user=" + $sourceuserid + ";pwd=" + $sourcepwd + ";Timeout = 0;"
    #$SrcConnStr = “Data Source=" + $sourceserver + ";Initial Catalog=" + $sourcedatabase + ";Integrated Security=True;Timeout = 0;”
    $SrcConn  = New-Object System.Data.SqlClient.SQLConnection($SrcConnStr)
    $CmdText = “SELECT * FROM SpeedSections WITH (NOLOCK)“ 
    $SqlCommand = New-Object system.Data.SqlClient.SqlCommand($CmdText, $SrcConn) 
    $SqlCommand.CommandTimeout = 0 
    $SrcConn.Open()

    # Read Source Data
    [System.Data.SqlClient.SqlDataReader] $SqlReader = $SqlCommand.ExecuteReader()

    # Setup Destionation Connection Parameters
    $DestConnStr = “Data Source=" + $DestinationServer + ";Initial Catalog=" + $destinationdatabase + ";Integrated Security=True;Timeout = 0;”
    $DstConn = New-Object System.Data.SqlClient.SQLConnection($DestConnStr)
    $DstConn.Open()

    $CmdText = “TRUNCATE TABLE cle.SpeedSections“ 
    $SqlCommand = New-Object system.Data.SqlClient.SqlCommand($CmdText, $DstConn) 
    $SQLCommand.ExecuteNonQuery()
    $DstConn.Close();

    $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestConnStr, [System.Data.SqlClient.SqlBulkCopyOptions]::KeepIdentity)
    $bulkCopy.DestinationTableName = $schemaname + ".SpeedSections"
    $bulkcopy.BulkCopyTimeout = 0

    # Copy Source To Destination
    $bulkCopy.WriteToServer($sqlReader)

    # Update Audit row
    $SqlCmd.CommandText = "dbo.prcUpdateDimAudit"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
    $SqlCmd.ExecuteNonQuery()

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