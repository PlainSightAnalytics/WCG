<# 
----------------------------------------------------------------------------------------------------------------
Script:  LoadMaster6AM
Purpose: Runs stage and load scripts for CLE, EBAT, ITIS and Impound to close off previous operations day at 6AM
Author:  Trevor Howe
Date:    09-08-2019
----------------------------------------------------------------------------------------------------------------
Change Date:
Changed by:
Change:
----------------------------------------------------------------------------------------------------------------
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

    # EBAT(Stage, Load, Upload, Refresh)
    Invoke-Expression ($ScriptFolder + "LoadMasterEBAT.ps1")

    # CLE (Stage, Load)
    Invoke-Expression ($ScriptFolder + "LoadMasterCLE.ps1")

    # Freight (Load)
    Invoke-Expression ($ScriptFolder + "LoadDimTrip.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactFreightTracking.ps1")

    # Speed Profiles (Load, Upload)
    Invoke-Expression ($ScriptFolder + "LoadMasterSpeedProfiles.ps1")

    # Upload CLE (Upload)
    Invoke-Expression ($ScriptFolder + "UploadModelDataCLE.ps1")

    # Refresh Dashboards (Refresh)
    Invoke-Expression ($ScriptFolder + "RefreshDatasetPublicTransport.ps1")
    Invoke-Expression ($ScriptFolder + "RefreshDatasetFreightTracking.ps1")
    Invoke-Expression ($ScriptFolder + "RefreshDatasetSpeedProfiles.ps1")


    # ITIS and Impound (Stage, Load, Upload, Refresh)
    Invoke-Expression ($ScriptFolder + "LoadMasterITIS.ps1")

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