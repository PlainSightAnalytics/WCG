<# 
Script:  LoadMaster
Purpose: Runs stage and load scripts for Impound
Author:  Trevor Howe
Date:    08-02-2019
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

    # Stage Data - Non Delta Tables
    Invoke-Expression ($ScriptFolder + "LoadStageImpoundNonDeltaTables.ps1")
 
    # Stage Date - Delta Tables
    Invoke-Expression ($ScriptFolder + "LoadStageImpoundDeltaTables")

    # Load ITIS Dimensions
    Invoke-Expression ($ScriptFolder + "LoadDimDriverPND.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimVehiclePND.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimTrafficCentrePND.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimJourneyUserPND.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimImpoundInstruction.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimPoundFacility.ps1")

    # Load ITIS Facts
    Invoke-Expression ($ScriptFolder + "LoadFactImpoundEvents.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactImpoundReleaseCosts.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactImpoundViolationCharges.ps1")

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