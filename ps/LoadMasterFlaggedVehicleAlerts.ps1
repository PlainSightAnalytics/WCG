<# 
Script:  LoadMasterFlaggedVehicleAlerts
Purpose: Stage and load flagged vehicle alerts and then push to Journey
Author:  Trevor Howe
Date:    10-03-2019
#>


# Declare Variables
$pa_ScriptName =  $script:MyInvocation.MyCommand.Path
$pa_ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Variables
    $pa_ExecutionLogKey = -1

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

    # Stage Data - Latest Sightings and VehicleEnquiryResponses
    Invoke-Expression ($pa_ScriptFolder + "LoadStageSightingsLatest.ps1")
    Invoke-Expression ($pa_ScriptFolder + "LoadStageVehicleEnquiryResponsesLatest.ps1")
    
    # Load Dimensions
    Invoke-Expression ($pa_ScriptFolder + "LoadDimFlaggedVehicleTrip")
    
    # Load Facts
    Invoke-Expression ($pa_ScriptFolder + "LoadFactFlaggedVehicleAlerts.ps1")

    # Push Alerts to Journey
    Invoke-Expression ($pa_ScriptFolder + "PushAlertsToJourney.ps1")


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