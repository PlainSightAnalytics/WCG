<# 
----------------------------------------------------------------------------------------------------------------
Script:  LoadMaster
Purpose: Runs stage and load scripts for ITIS
Author:  Trevor Howe
Date:    04-11-2018
----------------------------------------------------------------------------------------------------------------
Change Date: 12-08-2019
Changed by: Trevor Howe
Change: Added calls to Refresh Data scripts to refresh ENFORCE and Impound Dashboard datasets
----------------------------------------------------------------------------------------------------------------
#>

# Exit if time before 6am or after 10pm
$Now = Get-Date 

if ($Now.Hour -lt 6 -OR $Now.Hour -ge 22) {exit}


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

    # Stage Data - ITIS Delta Tables
    Invoke-Expression ($ScriptFolder + "LoadStageITISDeltaTables.ps1")
    #Invoke-Expression ($ScriptFolder + "LoadStageVehicle.ps1")

    # Stage Data - Impound Delta Tables
    Invoke-Expression ($ScriptFolder + "LoadStageImpoundDeltaTables")

    # Stage Data - ITIS Dimensions
    Invoke-Expression ($ScriptFolder + "LoadStageITISNonDeltaTables.ps1")

    # Stage Data - Impound Non Delta Tables
    Invoke-Expression ($ScriptFolder + "LoadStageImpoundNonDeltaTables.ps1")

    # Load ITIS Dimensions
    Invoke-Expression ($ScriptFolder + "LoadDimAPPTarget.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimDevice.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimDriverITIS.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimOperation.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimRoadSafetyTopic.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimRoster.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimSection56Form.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimShiftLocation.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimShiftTask.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimShiftTime.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimShiftWeek.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimTrafficCentre.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimUser.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimVehicleITIS")
    Invoke-Expression ($ScriptFolder + "LoadDimViolationCharge.ps1")
    
    # Load Impound Dimensions
    Invoke-Expression ($ScriptFolder + "LoadDimDriverPND.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimImpoundInstruction.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimJourneyUserPND.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimPoundFacility.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimTrafficCentrePND.ps1")
    Invoke-Expression ($ScriptFolder + "LoadDimVehiclePND.ps1")


    # Load ITIS Facts
    Invoke-Expression ($ScriptFolder + "LoadFactTrafficControlEvents.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactTrafficControlEventOutcomes.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactAPPTargets.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactAPPActuals.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactImpoundRequests.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactOperationAssignments.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactPlannedOperations.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactPlannedShifts.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactRoadSafetyEducationEvents.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactShiftActivities.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactShiftOutcomes.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactShiftTasks.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactShiftTimes.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactDeviceHistory.ps1")

    # Load Impound Facts
    Invoke-Expression ($ScriptFolder + "LoadFactImpoundEvents.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactImpoundReleaseCosts.ps1")
    Invoke-Expression ($ScriptFolder + "LoadFactImpoundViolationCharges.ps1")

    <# Upload model tables #>
    Invoke-Expression ($ScriptFolder + "UploadModelDataITIS.ps1")

    # Refresh Datasets via API
    Invoke-Expression ($ScriptFolder + "RefreshDatasetENFORCE.ps1")
    Invoke-Expression ($ScriptFolder + "RefreshDatasetImpoundment.ps1")
    Invoke-Expression ($ScriptFolder + "RefreshDatasetTransportOperations.ps1")

    # Upload Logs
    Invoke-Expression ($ScriptFolder + "UploadLogs.ps1")
    Invoke-Expression ($ScriptFolder + "UploadExecutionLog.ps1")

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

