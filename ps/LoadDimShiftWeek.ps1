﻿<# 
Script:  LoadDimShiftWeek
Purpose: Loads new and updated rows to DimShiftWeek
Author:  Trevor Howe
Date:    06-05-2018
#>

# Declare Variables
$ScriptName =  $script:MyInvocation.MyCommand.Path
$ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Variables
    $tablename = "DimShiftWeek"
    $clientname = "WCG"
    $schemaname = "itis"
    $objectname = "shift_week"
    $auditkey = -1
    $ExecutionLogKey = 0
    $UnloadedDeltas = @()
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

    # Get Unloaded Deltas
    $SqlCmd.CommandText = "dbo.prcGetUnloadedDeltas"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
    $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
    $SqlCmd.Parameters.AddWithValue("@ObjectName",$objectname)
    #$SqlCmd.Parameters.AddWithValue("@ReturnDeltas",100)
    $SqlDataReader = $SqlCmd.ExecuteReader()
    $SqlCmd.Parameters.Clear()

    # For each unloaded Delta run Load Stored Procedure
    while ($SqlDataReader.Read())
    {
        $DeltaLogKey = $SqlDataReader["DeltaLogKey"]
        $UnloadedDeltas += $DeltaLogKey
    }

    $SqlDataReader.Close()

    if ($UnloadedDeltas.Count -gt 0)
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
    }

    foreach ($DeltaLogKey in $UnloadedDeltas) {

        $SqlCmd.CommandText = "dbo.prcLoad" + $TableName
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
        $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
        $SqlCmd.CommandTimeout = 0
        $SqlCmd.ExecuteNonQuery()
        $SqlCmd.Parameters.Clear()

    }

    # Update Audit row
    $SqlCmd.CommandText = "dbo.prcUpdateDimAudit"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
    $SqlCmd.ExecuteNonQuery()

    # Check for new data
    <#$SqlCmd.CommandText = "dbo.prcGetSetDimDeltaLogFlag"
    
    $objects = @("shift_week","roster_week")

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
        $SqlCmd.CommandText = "dbo.prcLoad" + $TableName
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
        $SqlCmd.ExecuteNonQuery()

        # Update Delta Log
        $SqlCmd.CommandText = "dbo.prcGetSetDimDeltaLogFlag"
        
        $objects = @("shift_week","roster_week")

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



    }#>
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

