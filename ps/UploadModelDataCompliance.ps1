﻿<# 
Script:  UploadModelDataCompliance.ps1
Purpose: Uploads model data for Compliance to Model Server and Database
Author:  Trevor Howe
Date:    04-11-2019
#>


# Declare Common Variables
$schemaname = "model"
$executionlogkey = 0
$scriptname =  $script:MyInvocation.MyCommand.Path
$MaxCalendarYearMonthKey = (Get-Date).AddMonths(-1).ToString('yyyyMM')

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
                     "Vehicle Type"
                    ,"Alert Type"
                    ,"Camera"
                    ,"Month"
                    ,"Speed Profile Bucket"
                    ,"Violation Charge"
                   )

    foreach ($modeltable in $modeltables) {

        # Log Start of Delete
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcInsertDimModelTableLog"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@ModelTable",$modeltable)
        $SqlCmd.Parameters.AddWithValue("@Action","DELETE")
        $SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
        $OutputParm = $SQLCmd.Parameters.AddWithValue("@LogKey",$LogKey)
        $OutputParm.Direction = 'Output'
        $SqlCmd.ExecuteNonQuery()
        $LogKey = $OutputParm.Value

        # Setup SQL Command for table delete
        $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $DestinationSQLCmd.Connection = $DestinationConnection
        $DestinationSQLCmd.CommandText = "DELETE FROM [" + $schemaname + "].[" + $modeltable + "]"
        $DestinationSQLCmd.CommandTimeout = 0
        $DestinationSQLCmd.ExecuteNonQuery()

        # Log End of Delete 
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimModelTableLog"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@LogKey",$LogKey)
        $SqlCmd.ExecuteNonQuery()

        # Log Start of Bulk Copy
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcInsertDimModelTableLog"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@ModelTable",$modeltable)
        $SqlCmd.Parameters.AddWithValue("@Action","BULK COPY")
        $SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
        $OutputParm = $SQLCmd.Parameters.AddWithValue("@LogKey",$LogKey)
        $OutputParm.Direction = 'Output'
        $SqlCmd.ExecuteNonQuery()
        $LogKey = $OutputParm.Value

        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [" + $schemaname + "].[" + $modeltable + "]"

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        
        $modeltable
        $bulkCopy.DestinationTableName = "[" + $schemaname + "].[" + $modeltable + "]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()

        # Log End of Bulk Copy 
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimModelTableLog"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@LogKey",$LogKey)
        $SqlCmd.ExecuteNonQuery()

    }

    # Declare model tables to be copied - replace most recent deltas
    $modeltables = @(
                     "_Monthly Flagged Alerts"
                    ,"_Monthly Alerts"
                    ,"_Monthly Sightings"
                    ,"_Monthly Traffic Control Events"
                    ,"_Monthly Traffic Control Event Outcomes"
                    ,"_Monthly Speed Profiles"
                   )

    foreach ($modeltable in $modeltables) {


        # Log Start of Delete
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcInsertDimModelTableLog"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@ModelTable",$modeltable)
        $SqlCmd.Parameters.AddWithValue("@Action","DELETE")
        $SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
        $OutputParm = $SQLCmd.Parameters.AddWithValue("@LogKey",$LogKey)
        $OutputParm.Direction = 'Output'
        $SqlCmd.ExecuteNonQuery()
        $LogKey = $OutputParm.Value

        # Setup SQL Command for table delete
        $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
        $DestinationSQLCmd.Connection = $DestinationConnection
        $DestinationSQLCmd.CommandText = "DELETE FROM [" + $schemaname + "].[" + $modeltable + "] WHERE CalendarYearMonthKey >= " + $MaxCalendarYearMonthKey
        $DestinationSQLCmd.CommandTimeout = 0
        $DestinationSQLCmd.ExecuteNonQuery()
            
        # Log End of Delete 
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimModelTableLog"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@LogKey",$LogKey)
        $SqlCmd.ExecuteNonQuery()

        # Log Start of Bulk Copy
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcInsertDimModelTableLog"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@ModelTable",$modeltable)
        $SqlCmd.Parameters.AddWithValue("@Action","BULK COPY")
        $SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
        $OutputParm = $SQLCmd.Parameters.AddWithValue("@LogKey",$LogKey)
        $OutputParm.Direction = 'Output'
        $SqlCmd.ExecuteNonQuery()
        $LogKey = $OutputParm.Value

        # SQL Command for table select
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT * FROM [" + $schemaname + "].[" + $modeltable + "] WHERE CalendarYearMonthKey = " + $MaxCalendarYearMonthKey

        # Get source data
        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        # Bulk copy to destination
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection)
        
        $bulkCopy.DestinationTableName = "[" + $schemaname + "].[" + $modeltable + "]"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()

        # Log End of Bulk Copy 
        $SqlCmd.CommandText = "WCG_Stage.dbo.prcUpdateDimModelTableLog"
        $SqlCmd.Parameters.Clear()
        $SqlCmd.Parameters.AddWithValue("@LogKey",$LogKey)
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