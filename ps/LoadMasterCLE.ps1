<# 
------------------------------------------------------------------
Script:  LoadMaster
Purpose: Executes Power Shell scripts to stage and load CLE data
Author:  Trevor Howe
Date:    08-02-2019
------------------------------------------------------------------
Change Date: 09-08-2019
Changed by:  Trevor Howe
Change: Removed upload scripts, these will be done via the 6AM job
------------------------------------------------------------------
#>


# Declare Variables
$ScriptName =  $script:MyInvocation.MyCommand.Path
$ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Variables
    $ExecutionLogKey = -1

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

    # Load Non Delta Stage Tables
    Invoke-Expression ($ScriptFolder + "ExtractCameraMapping.ps1")
    Invoke-Expression ($ScriptFolder + "ExtractPublicHolidays.ps1")
    Invoke-Expression ($ScriptFolder + "LoadStageSpeedSections.ps1")

    # Load Delta Stage Tables
    Invoke-Expression ($ScriptFolder + "LoadStageSightings.ps1")
    Invoke-Expression ($ScriptFolder + "LoadStageAlerts.ps1")
    Invoke-Expression ($ScriptFolder + "LoadStageVehicleEnquiryResponses.ps1")

    # Load Dimensions
    Invoke-Expression ($ScriptFolder + "LoadDimDate.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimCamera.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimVehicle.ps1")

    # Load Facts
    Invoke-Expression ($ScriptFolder + "LoadFactSightings.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactAlerts.ps1")

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