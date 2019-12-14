<# 
Script:  LoadMaster
Purpose: Runs stage and load scripts for Last Known Location
Author:  Trevor Howe
Date:    29-03-2019
#>


# Declare Variables
$lkn_ScriptName =  $script:MyInvocation.MyCommand.Path
$lkn_ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Variables
    $lkn_ExecutionLogKey = -1

    # Set SQL Connection and Command Objects
    $lkn_SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $lkn_SqlConnection.ConnectionString = "Server= $wcgserver ;Database= $wcgstagedb ;Integrated Security=True"
    $lkn_SqlConnection.Open()
    $lkn_SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $lkn_SqlCmd.Connection = $lkn_SqlConnection
    $lkn_SqlCmd.CommandType = [System.Data.CommandType]'StoredProcedure'

    # Stage
    Invoke-Expression ($lkn_ScriptFolder + "LoadStageLastKnownLocationCurrent.ps1")
         
    # Upload model tables 
    Invoke-Expression ($lkn_ScriptFolder + "UploadLastKnownLocation.ps1")

}
Catch
{

    # Save Exception Details
    $lkn_ExceptionMessage = $_.Exception.Message.Trim()
    $lkn_ExceptionLine = $_.InvocationInfo.Line.Trim()
    $lkn_ExectptionLineNo = $_.InvocationInfo.ScriptLineNumber

    # Create Execution Log
    $lkn_SqlCmd.CommandText = "prcInsertDimExecutionLog"
    $lkn_SqlCmd.Parameters.Clear()
    $lkn_SqlCmd.Parameters.AddWithValue("@ScriptName",$lkn_ScriptName)
    $lkn_OutputParm = $lkn_SQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$lkn_ExecutionLogKey)
    $lkn_OutputParm.Direction = 'Output'
    $lkn_SqlCmd.ExecuteNonQuery()
    $lkn_ExecutionLogKey = $lkn_OutputParm.Value

    # Update Execution Log with Exception Details and Close
    $lkn_SqlCmd.CommandText = "prcUpdateDimExecutionLog"
    $lkn_SqlCmd.Parameters.Clear()
    $lkn_SqlCmd.Parameters.AddWithValue("@ExecutionLogKey",$lkn_ExecutionLogKey)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionLineNo",$lkn_ExectptionLineNo)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionLine",$lkn_ExceptionLine)
    $lkn_SqlCmd.Parameters.AddWithValue("@ExceptionMessage",$lkn_ExceptionMessage)
    $lkn_SqlCmd.ExecuteNonQuery()

}
Finally
{

    $lkn_SqlConnection.Close()

}