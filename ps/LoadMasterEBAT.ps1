<# 
----------------------------------------------------------------------------------------------------------------
Script:  LoadMasterEBAT
Purpose: Executes Power Shell scripts to stage, load, upload, and refresh EBAT data
Author:  Trevor Howe
Date:    27-04-2019
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

    # Stage Date - Delta Tables
    Invoke-Expression ($ScriptFolder + "LoadStageEBATReport.ps1")

    # Stage Data - Non Delta Tables
    Invoke-Expression ($ScriptFolder + "LoadStageEBATNonDeltaTables.ps1")

    # Load EBAT Dimensions
    Invoke-Expression ($ScriptFolder + "LoadDimDriverEBAT.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimEbatDevice.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimMagistratesCourt.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimOfficer.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimOperator.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimVehicleEBAT.ps1")

    # Load EBAT Facts
    Invoke-Expression ($ScriptFolder + "LoadFactEBATReport.ps1")

    # Upload model tables
    Invoke-Expression ($ScriptFolder + "UploadModelDataEBAT.ps1")

    # Refresh Datasets via API
    Invoke-Expression ($ScriptFolder + "RefreshDatasetEBAT.ps1")

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