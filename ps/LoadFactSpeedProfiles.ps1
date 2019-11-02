<# 
Script:  LoadFactSpeedProfiles
Purpose: Loads new and updated rows to FactSpeedProfiles from Latest Sightings data
Author:  Trevor Howe
Date:    05-07-2019
#>

# Declare Variables
$ScriptName =  $script:MyInvocation.MyCommand.Path
$ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Variables
    $tablename = "FactSpeedProfiles"
    $clientname = "WCG"
    $schemaname = "cle"
    $objectname = ""
    $auditkey = -1
    $ExecutionLogKey = 0
    $result = 0
    $loadflag = 1
    $previoussightingdatekey = 0

    # Set SQL Connection and Command Objects
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = "Server= $wcgserver ;Database= $wcgstagedb ;Integrated Security=True"
    $SqlConnection.Open()
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.Connection = $SqlConnection
    $SqlCmd.CommandType = [System.Data.CommandType]'StoredProcedure'
    $SqlCmd.CommandTimeout = 0

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

    # Load Dim
    $SqlCmd.CommandText = "dbo.prcLoadFactSpeedProfiles"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
    $OutputParm = $SqlCmd.Parameters.AddWithValue("@PreviousSightingDateKey",$previoussightingdatekey)
    $OutputParm.Direction = 'Output'
    $SqlCmd.ExecuteNonQuery()
    $previoussightingdatekey = $OutputParm.Value

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

#Return Previous Sighting Date key to calling script
$previoussightingdatekey


