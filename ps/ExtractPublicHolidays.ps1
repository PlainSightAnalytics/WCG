<# 
Script:  ExtractPublicHolidays.ps1
Purpose: Loads Public Holidays from Text file to Stage table
Author:  Trevor Howe
Date:    18 June 2016
#>

$ScriptName =  $script:MyInvocation.MyCommand.Path

Try 
{
    # Declare Variables
    $folder = $wcgroot + "data\" 
    $filename = "Public Holidays.txt"
    $filenamefull = $folder + $filename
    $schemaname = "man"
    $ExecutionLogKey = 0
    $clientname = "WCG"
    $object = "PublicHolidays"
    $highwaterdatetime = [string] "1900-01-01T00:00:00Z"
    $rowupdated = 0
    $auditkey = -1

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

    # Get Last update time
    $highwaterdatetime = [string](Get-ItemProperty -Path $filenamefull).LastWriteTime.ToUniversalTime().ToString("yyyy-MM-dd-Thh:mm:ssZ")

    # Count rows in file
    $reader = New-Object IO.StreamReader $filenamefull
    $count = 0
    while($reader.ReadLine() -ne $null){ $count++ }
    $rowcountsource = $count
    $reader.close()
    
    # Get High Water Mark
    $SqlCmd.CommandText = "dbo.prcUpdateHighWaterMark"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
    $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
    $SqlCmd.Parameters.AddWithValue("@ObjectName",$object)
    $SqlCmd.Parameters.AddWithValue("@HighWaterDateTime",$highwaterdatetime)
    $SqlCmd.Parameters.AddWithValue("@RowCountSource",$rowcountsource)
    $OutputParm = $SqlCmd.Parameters.AddWithValue("@RowUpdated",$rowupdated)
    $OutputParm.Direction = 'Output'
    $SqlCmd.ExecuteNonQuery()
    $rowupdated = $OutputParm.Value

    # Only do the load if the last update date has changed
    If ($rowupdated -eq 1)
    {

        # Create Audit row 
        $SqlCmd.CommandText = "dbo.prcInsertDimAudit"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
        $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
        $SqlCmd.Parameters.AddWithValue("@TableName",$object)
        $SqlCmd.Parameters.AddWithValue("@ScriptName",$ScriptName)
        $OutputParm = $SqlCmd.Parameters.AddWithValue("@AuditKey",$auditkey)
        $OutputParm.Direction = 'Output'
        $SqlCmd.ExecuteNonQuery()
        $auditkey = $OutputParm.Value

        # Extract Public Holidays Text file to Stage table
        $SqlCmd.CommandText = $schemaname + ".prcExtractPublicHolidays"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@FileName",$folder + $filename)
        $SqlCmd.ExecuteNonQuery()

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
