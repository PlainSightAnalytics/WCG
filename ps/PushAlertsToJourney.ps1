<# 
Script:  PushAlertsToJourney
Purpose: Checks for new flagged vehicle alerts and sends results to Journey
Author:  Trevor Howe
Date:    10-03-2019

#>

# Declare Variables
$pa_ScriptName =  $script:MyInvocation.MyCommand.Path
$pa_ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Variables

    $pa_url = $journey_url + $itisuser + '/objects/alerts.json'
    $pa_token = $itistoken
    $pa_auth = $itisauth

    $pa_uniqueId = ''
    $pa_jsonstring = ''

    $pa_tablename = "FlaggedVehicleAlertLog"
    $pa_clientname = "WCG"
    $pa_schemaname = "cle"
    $pa_auditkey = -1
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

    # Create Audit row 
    $pa_SqlCmd.CommandText = "dbo.prcInsertDimAudit"
    $pa_SqlCmd.Parameters.Clear()
    $pa_SqlCmd.Parameters.AddWithValue("@ClientName",$pa_clientname)
    $pa_SqlCmd.Parameters.AddWithValue("@SchemaName",$pa_schemaname)
    $pa_SqlCmd.Parameters.AddWithValue("@TableName",$pa_TableName)
    $pa_SqlCmd.Parameters.AddWithValue("@ScriptName",$pa_ScriptName)
    $pa_OutputParm = $pa_SqlCmd.Parameters.AddWithValue("@AuditKey",$pa_auditkey)
    $pa_OutputParm.Direction = 'Output'
    $pa_SqlCmd.ExecuteNonQuery()
    $pa_auditkey = $pa_OutputParm.Value

    # Build authentication
    $pa_headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $pa_headers.Add('Content-Type', 'application/json')
    $pa_headers.Add('Accept', 'application/json')
    $pa_headers.Add('Authorization', $pa_auth)
    $pa_headers.Add('Postman-Token', $pa_token)

    # Set SQL Get Command Objects
    $pa_SqlGetCmd = New-Object System.Data.SqlClient.SqlCommand
    $pa_SqlGetCmd.Connection = $pa_SqlConnection
    $pa_SqlGetCmd.CommandType = [System.Data.CommandType]'StoredProcedure'
    $pa_SqlGetCmd.CommandText = "dbo.prcGetFlaggedVehicleAlert"

    # Set SQL Get Command Objects
    $pa_SqlSetCmd = New-Object System.Data.SqlClient.SqlCommand
    $pa_SqlSetCmd.Connection = $pa_SqlConnection
    $pa_SqlSetCmd.CommandType = [System.Data.CommandType]'StoredProcedure'
    $pa_SqlSetCmd.CommandText = "dbo.prcSetFlaggedVehicleAlert"

    # While there are alerts send them to Journey
    while ($true)
    {

        # Set Get Cmd Parameters and Execute Stored Proc (prcGetFlaggedVehicleAlert)
        $pa_SqlGetCmd.Parameters.Clear()
        $pa_OutputParm0 = $pa_SQLGetCmd.Parameters.AddWithValue("@UniqueId",$pa_uniqueId)
        $pa_OutputParm0.Direction = 'Output'
        $pa_OutputParm0.Size = 50
        $pa_OutputParm1 = $pa_SQLGetCmd.Parameters.AddWithValue("@JsonString",$pa_jsonstring)
        $pa_OutputParm1.Direction = 'Output'
        $pa_OutputParm1.Size = 5000
        $pa_SQLGetCmd.ExecuteNonQuery()

        # Break out of while loop if there is nothing to send
        $pa_alert = $pa_OutputParm1.Value
        if ([string]::IsNullOrEmpty($pa_alert))
        {
        break
        }

        # Tidy up JSON returned from Stored procedure before sending to Journey
        $pa_alert = $pa_OutputParm1.Value
        $pa_alert = @{
        alert = $pa_alert } 
        
        $pa_alert = $pa_alert | ConvertTo-Json
        $pa_alert = $pa_alert.Replace("[","")
        $pa_alert = $pa_alert.Replace("]","")
        $pa_alert = $pa_alert.Replace("\","")
        $pa_alert = $pa_alert.Replace('"{','{')
        $pa_alert = $pa_alert.Replace('}"','}')

        # Send the alert to Journey
        $pa_response = Invoke-RestMethod -Uri $pa_url -Method Post -Headers $pa_headers -Body $pa_alert

        # Break up unique id into parts to update alert delivery information
        $pa_uniqueidstring = $pa_OutputParm0.Value.Split('-')
        $pa_registrationno = $pa_uniqueidstring[0]
        $pa_sightingrecordid = $pa_uniqueidstring[1]
        $pa_flagtype = $pa_uniqueidstring[2]
        $pa_trafficcentrekey = $pa_uniqueidstring[3]
        
        # Mark alert as being sent on DW tables
        $pa_SqlSetCmd.Parameters.Clear()
        $pa_SqlSetCmd.Parameters.AddWithValue("@RegistrationNo",$pa_registrationno)
        $pa_SqlSetCmd.Parameters.AddWithValue("@SightingRecordId",$pa_sightingrecordid)
        $pa_SqlSetCmd.Parameters.AddWithValue("@FlagType",$pa_flagtype)
        $pa_SqlSetCmd.Parameters.AddWithValue("@TrafficCentreKey",$pa_trafficcentrekey)
        $pa_SqlSetCmd.ExecuteNonQuery()

    }

    # Update Audit row
    $pa_SqlCmd.CommandText = "dbo.prcUpdateDimAudit"
    $pa_SqlCmd.Parameters.Clear()
    $pa_SqlCmd.Parameters.AddWithValue("@AuditKey",$pa_AuditKey)
    $pa_SqlCmd.ExecuteNonQuery()

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