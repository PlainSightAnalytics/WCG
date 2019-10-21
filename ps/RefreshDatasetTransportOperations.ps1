<# 
----------------------------------------------------------------------------------------------------------------
Script:  RefreshModelDataTransportOperations.ps1
Purpose: Refreshes Power BI data set for Transport Operations dashboard on various accounts
Author:  Trevor Howe
Date:    11-10-2019
----------------------------------------------------------------------------------------------------------------
Change Date:
Changed by:
Change:
----------------------------------------------------------------------------------------------------------------

#>


# Declare Common Variables
$schemaname = "model"
$executionlogkey = 0
$scriptname =  $script:MyInvocation.MyCommand.Path
$DeltaLogKey = 0

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

    <# Refresh Dataset in app.powerbi.com (WCG)

    # Setup Authorisation parameters
    $clientId = $wcgclientId
    $pbiUsername = $wcgpbiUsername
    $pbiPassword = $wcgpbiPassword

    $pbiDatasetId = "<Copy new dataset id here>"
    $authUrl = "https://login.windows.net/common/oauth2/token/"

    $body = @{
        "resource" = “https://analysis.windows.net/powerbi/api";
        "client_id" = $clientId;
        "grant_type" = "password";
        "username" = $pbiUsername;
        "password" = $pbiPassword;
        "scope" = "openid"
    }

    # Get Authorisation
    $authResponse = Invoke-RestMethod -Uri $authUrl –Method POST -Body $body
    
    # Setup Refresh parameters
    $restURL = "https://api.powerbi.com/v1.0/myorg/datasets/$pbiDatasetId/refreshes"

    $headers = @{
        "Content-Type" = "application/json";
        "Authorization" = $authResponse.token_type + " " + $authResponse.access_token
    }

    # Refresh Data
    $restResponse = Invoke-RestMethod -Uri $restURL –Method POST -Headers $headers#>

    # Refresh Dataset in app.powerbi.com (PlainSight)

    # Setup Authorisation parameters
    $clientId = $psaclientId
    $pbiUsername = $psapbiUsername
    $pbiPassword = $psapbiPassword

    $pbiDatasetId = "7901673e-4871-49ab-bfae-2c0aff1cec22"
    $authUrl = "https://login.windows.net/common/oauth2/token/"

    $body = @{
        "resource" = “https://analysis.windows.net/powerbi/api";
        "client_id" = $clientId;
        "grant_type" = "password";
        "username" = $pbiUsername;
        "password" = $pbiPassword;
        "scope" = "openid"
    }

    # Get Authorisation
    $authResponse = Invoke-RestMethod -Uri $authUrl –Method POST -Body $body
    
    # Setup Refresh parameters
    $restURL = "https://api.powerbi.com/v1.0/myorg/datasets/$pbiDatasetId/refreshes"

    $headers = @{
        "Content-Type" = "application/json";
        "Authorization" = $authResponse.token_type + " " + $authResponse.access_token
    }

    # Refresh Data
    $restResponse = Invoke-RestMethod -Uri $restURL –Method POST -Headers $headers 


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

}