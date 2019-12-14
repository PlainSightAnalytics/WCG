<# 
Script:  UploadVehicleSearch.ps1
Purpose: Uploads Vehicle Search data from DW tables to App Server
Author:  Trevor Howe
Date:    07-12-2019
#>


# Declare Common Variables
$clientname = "WCG"
$schemaname = "dbo"
$objectname = "VehicleSearch"
$executionlogkey = 0
$scriptname =  $script:MyInvocation.MyCommand.Path
$DeltaLogKey = 0
$UnloadedDeltas = @()
$MonthKey = 201901

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
    $DestinationConnectionString = "Server=tcp:$appserver;Database=$appdatabase;Uid=$appuserid;Pwd=$apppwd;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"
    #$DestinationConnectionString = "Server= $wcgserver ;Database= $pbidatabase ;Integrated Security=True"
    $DestinationConnection = New-Object System.Data.SqlClient.SqlConnection
    $DestinationConnection.ConnectionString = $DestinationConnectionString
    $DestinationConnection.Open()

    # Setup SQL Command for Source Select
    $SourceSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $SourceSQLCmd.Connection = $SourceConnection
    $SourceSQLCmd.CommandTimeout = 0

    # Get Unloaded Deltas
    $SqlCmd.CommandText = "WCG_Stage.dbo.prcGetUnloadedDeltas"
    $SqlCmd.Parameters.Clear()
    $SqlCmd.Parameters.AddWithValue("@ClientName",$clientname)
    $SqlCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
    $SqlCmd.Parameters.AddWithValue("@ObjectName",$objectname)
    $SqlDataReader = $SqlCmd.ExecuteReader()
    $SqlCmd.Parameters.Clear()

    # For each unloaded Delta run Load Stored Procedure
    while ($SqlDataReader.Read())
    {
        $DeltaLogKey = $SqlDataReader["DeltaLogKey"]
        $UnloadedDeltas += $DeltaLogKey
    }

    $SqlDataReader.Close()

    foreach ($DeltaLogKey in $UnloadedDeltas) {

        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [WCG_DW].[dbo].[VehicleSearch] WHERE DeltaLogKey = " + $DeltaLogKey

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        $bulkCopy.DestinationTableName = "[dbo].[VehicleSearch]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)

        # Close and Dispose Objects
        $bulkCopy.Close()
        $bulkCopy.Dispose()
        $SqlReader.Close()
        $SqlReader.Dispose()

        # Update LoadFlag to 1 (to indicate its been upoaded)
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimDeltaLogLoadFlag"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
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
