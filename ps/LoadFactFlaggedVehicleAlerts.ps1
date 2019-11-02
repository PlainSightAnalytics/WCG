<# 
Script:  LoadFactFlaggedVehicleAlerts
Purpose: Loads new and updated rows to FactFlaggedVehicleAlerts
Author:  Trevor Howe
Date:    10-03-2019

#>

# Declare Variables
$pa_ScriptName =  $script:MyInvocation.MyCommand.Path
$pa_ScriptFolder = $wcgroot + "ps\"

Try 
{


    # Declare Variables
    $pa_tablename = "FactFlaggedVehicleAlerts"
    $pa_clientname = "WCG"
    $pa_schemaname = "cle"
    $pa_auditkey = -1
    $pa_ExecutionLogKey = -1
    $pa_UnloadedDeltas = @()

    # Set SQL Connection and Command Objects
    $pa_SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $pa_SqlConnection.ConnectionString = "Server= $wcgserver ;Database= $wcgstagedb ;Integrated Security=True"
    $pa_SqlConnection.Open()
    $pa_SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $pa_SqlCmd.Connection = $pa_SqlConnection
    $pa_SqlCmd.CommandType = [System.Data.CommandType]'StoredProcedure'

    # Create Execution Log
    $pa_SqlCmd.CommandText = "prcInsertDimExecutionLog"
    $pa_SqlCmd.Parameters.Clear()
    $pa_SqlCmd.Parameters.AddWithValue("@ScriptName",$pa_ScriptName)
    $pa_OutputParm = $pa_SQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$pa_ExecutionLogKey)
    $pa_OutputParm.Direction = 'Output'
    $pa_SqlCmd.ExecuteNonQuery()
    $pa_ExecutionLogKey = $pa_OutputParm.Value

    # Create Audit row 
    $pa_SqlCmd.CommandText = "dbo.prcInsertDimAudit"
    $pa_SqlCmd.Parameters.Clear()
    $pa_SqlCmd.Parameters.AddWithValue("@ClientName",$pa_clientname)
    $pa_SqlCmd.Parameters.AddWithValue("@SchemaName",$pa_schemaname)
    $pa_SqlCmd.Parameters.AddWithValue("@TableName",$pa_TableName)
    $pa_SqlCmd.Parameters.AddWithValue("@ScriptName",$pa_ScriptName)
    $pa_OutputParm = $pa_SqlCmd.Parameters.AddWithValue("@AuditKey",$pa_auditkey)
    $pa_OutputParm.Direction = 'Output'
    $pa_SqlCmd.ExecuteNonQuery()
    $pa_auditkey = $pa_OutputParm.Value

    $pa_SqlCmd.CommandText = "dbo.prcLoad" + $pa_TableName
    $pa_SqlCmd.Parameters.Clear()
    $pa_SqlCmd.Parameters.AddWithValue("@AuditKey",$pa_AuditKey)
    $pa_SqlCmd.CommandTimeout = 0
    $pa_SqlCmd.ExecuteNonQuery()

    # Update Audit row
    $pa_SqlCmd.CommandText = "dbo.prcUpdateDimAudit"
    $pa_SqlCmd.Parameters.Clear()
    $pa_SqlCmd.Parameters.AddWithValue("@AuditKey",$pa_AuditKey)
    $pa_SqlCmd.ExecuteNonQuery()


}
Catch
{

    # Save Exception Details
    $pa_ExceptionMessage = $_.Exception.Message.Trim()
    $pa_ExceptionLine = $_.InvocationInfo.Line.Trim()
    $pa_ExectptionLineNo = $_.InvocationInfo.ScriptLineNumber

    # Update Execution Log with Exception Details and Close
    $pa_SqlCmd.CommandText = "prcUpdateDimExecutionLog"
    $pa_SqlCmd.Parameters.Clear()
    $pa_SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$pa_ExecutionLogKey)
    $pa_SqlCmd.Parameters.AddWithValue("@ExceptionLineNo",$pa_ExectptionLineNo)
    $pa_SqlCmd.Parameters.AddWithValue("@ExceptionLine",$pa_ExceptionLine)
    $pa_SqlCmd.Parameters.AddWithValue("@ExceptionMessage",$pa_ExceptionMessage)
    $pa_SqlCmd.ExecuteNonQuery()

}
Finally
{

    # Close off Execution Log
    $pa_SqlCmd.CommandText = "prcUpdateDimExecutionLog"
    $pa_SqlCmd.Parameters.Clear()
    $pa_SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$pa_ExecutionLogKey)
    $pa_SqlCmd.ExecuteNonQuery()

    $pa_SqlConnection.Close()

}

