<# 
Script:  LoadDimDriverEBATReport
Purpose: Loads new and updated rows to DimDriver
Author:  Trevor Howe
Date:    02-09-2018
#>

# Declare Variables
$ScriptName =  $script:MyInvocation.MyCommand.Path
$ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Variables
    $tablename = "DimDriver"
    $clientname = "WCG"
    $schemaname = "ebat"
    $objectname = "driver"
    $auditkey = -1
    $ExecutionLogKey = 0
    $result = 0
    $loadflag = 1

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

    # Check for new data
    $SqlCmd.CommandText = "dbo.prcGetSetDimDeltaLogFlag"
    
    $objects = @("driver")

    foreach ($object in $objects) {
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
        $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
        $SqlCmd.Parameters.AddWithValue("@ObjectName",$object)
        $SqlCmd.Parameters.AddWithValue("@Action",0)
        $OutputParm = $SQLCmd.Parameters.AddWithValue("@Result",$result)
        $OutputParm.Direction = 'Output'
        $SqlCmd.ExecuteNonQuery()
        $result = $OutputParm.Value
        if ($result -eq 0) 
        {
            $loadflag = 0
        }    
    }

    if ($loadflag -eq 0) 
    {
        
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
        $SqlCmd.CommandText = "dbo.prcLoadDimDriverEBATReport"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
        $SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
        $SqlCmd.ExecuteNonQuery()

        # Update Delta Log
        $SqlCmd.CommandText = "dbo.prcGetSetDimDeltaLogFlag"
        
        foreach ($object in $objects) {
    
            $SqlCmd.Parameters.Clear()
            $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
            $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
            $SqlCmd.Parameters.AddWithValue("@ObjectName",$object)
            $SqlCmd.Parameters.AddWithValue("@Action",1)
            $OutputParm = $SQLCmd.Parameters.AddWithValue("@Result",$result)
            $OutputParm.Direction = 'Output'
            $SqlCmd.ExecuteNonQuery()
            $result = $OutputParm.Value

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


