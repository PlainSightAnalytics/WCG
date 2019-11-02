<# 
----------------------------------------------------------------------------------------------------------------
Script:  UploadModelDataSpeedProfiles.ps1
Purpose: Uploads model data for Speed Profiles to Model Server and Database
Author:  Trevor Howe
Date:    05-07-2019
----------------------------------------------------------------------------------------------------------------
Change Date: 12-08-2019
Changed by: Trevor Howe
Change: Remove logic to refresh dataset, this is now done in a separate script called from the Load Master script
----------------------------------------------------------------------------------------------------------------
#>


# Declare Common Variables
$schemaname = "model"
$executionlogkey = 0
$scriptname =  $script:MyInvocation.MyCommand.Path
$DeltaLogKey = 0
$LastSightingDateKey = $args[0]

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
    #$DestinationConnectionString = "Server= $wcgserver ;Database= $pbidatabase ;Integrated Security=True"
    $DestinationConnection = New-Object System.Data.SqlClient.SqlConnection
    $DestinationConnection.ConnectionString = $DestinationConnectionString
    $DestinationConnection.Open()

    # Setup SQL Command for Source Select
    $SourceSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $SourceSQLCmd.Connection = $SourceConnection
    $SourceSQLCmd.CommandTimeout = 0

    # Declare model tables to be copied - flush and load
    $modeltables = @(
                     "Date"
                    ,"Camera"
                    ,"Speed Profile Bucket"
                    ,"Vehicle Type"
                   )

    foreach ($modeltable in $modeltables) {

        # Setup SQL Command for table delete
        $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $DestinationSQLCmd.Connection = $DestinationConnection
        $DestinationSQLCmd.CommandText = "DELETE FROM [" + $schemaname + "].[" + $modeltable + "]"
        $DestinationSQLCmd.CommandTimeout = 0
        $DestinationSQLCmd.ExecuteNonQuery()

        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [" + $schemaname + "].[" + $modeltable + "]"

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        
        $bulkCopy.DestinationTableName = "[" + $schemaname + "].[" + $modeltable + "]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()

    }

        # Declare model tables to be copied - replace most recent deltas
    $modeltables = @(
                     "_Speed Profiles"
                   )

    foreach ($modeltable in $modeltables) {

        # Setup SQL Command for table delete
        $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $DestinationSQLCmd.Connection = $DestinationConnection
        $DestinationSQLCmd.CommandText = "DELETE FROM [" + $schemaname + "].[" + $modeltable + "] WHERE SightingDateKey >= " + $LastSightingDateKey.ToString()
        $DestinationSQLCmd.CommandTimeout = 0
        $DestinationSQLCmd.ExecuteNonQuery()

        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [" + $schemaname + "].[" + $modeltable + "] WHERE SightingDateKey >= " + $LastSightingDateKey.ToString()

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        
        $bulkCopy.DestinationTableName = "[" + $schemaname + "].[" + $modeltable + "]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()
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