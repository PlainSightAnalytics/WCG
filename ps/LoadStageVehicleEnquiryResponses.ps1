﻿<# 
Script:  LoadStageVehicleEnquiryResponses.ps1
Purpose: Loads latest data from VehicleEnquiryResponses CLE
Author:  Trevor Howe
Date:    6 August 2016
#>

# Declare Variables
$ScriptName =  $script:MyInvocation.MyCommand.Path
$ScriptFolder = $wcgroot + "ps\"

Try 
{

    # Declare Common Variables
    $RowCountSource = 0
    $rowcountstage = 0 
    $deltalogkey = 1
    $previousdeltalogkey = 0
    $auditkey = -1
    $PreviousHighWaterMark = ""
    $HighWaterMark = 0
    $clientname = "WCG"
    $schemaname = "cle"
    $object = "VehicleEnquiryResponses"
    $ExecutionLogKey = 0
    $StageTable = "[" + $schemaname + "].[" + $object + "]"

    # Set SQL Connection and Command Objects
    $DestinationConnection = New-Object System.Data.SqlClient.SqlConnection
    $DestinationConnection.ConnectionString = "Server= $wcgserver ;Database= $wcgstagedb ;Integrated Security=True"
    $DestinationConnection.Open()
    $DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $DestinationSQLCmd.Connection = $DestinationConnection
    $DestinationSQLCmd.CommandType = [System.Data.CommandType]'StoredProcedure'

    # Create Execution Log
    $DestinationSQLCmd.CommandText = "prcInsertDimExecutionLog"
    $DestinationSQLCmd.Parameters.Clear()
    $DestinationSQLCmd.Parameters.AddWithValue("@ScriptName",$ScriptName)
    $OutputParm = $DestinationSQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
    $OutputParm.Direction = 'Output'
    $DestinationSQLCmd.ExecuteNonQuery()
    $ExecutionLogKey = $OutputParm.Value

    # Create Audit row 
    $DestinationSQLCmd.CommandText = "dbo.prcInsertDimAudit"
    $DestinationSQLCmd.Parameters.Clear()
    $DestinationSQLCmd.Parameters.AddWithValue("@ClientName",$clientname)
    $DestinationSQLCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
    $DestinationSQLCmd.Parameters.AddWithValue("@TableName",$object)
    $DestinationSQLCmd.Parameters.AddWithValue("@ScriptName",$ScriptName)
    $OutputParm = $DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$auditkey)
    $OutputParm.Direction = 'Output'
    $DestinationSQLCmd.ExecuteNonQuery()
    $auditkey = $OutputParm.Value

    # Get last Record Id from DeltaLog
    $DestinationSQLCmd.CommandText = "dbo.prcGetHighWaterMarkVehicleEnquiryResponses"
    $DestinationSQLCmd.Parameters.Clear()
    $DestinationSQLCmd.Parameters.AddWithValue("@ClientName",$clientname)
    $DestinationSQLCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
    $OutputParm = $DestinationSQLCmd.Parameters.AddWithValue("@HighWaterMark",$PreviousHighWaterMark)
    $OutputParm.Direction = 'Output'
    $OutputParm.DbType = [System.Data.DbType]'String';
    $OutputParm.Size = 20
    $DestinationSQLCmd.ExecuteNonQuery()
    $previousHighWaterMark = $OutputParm.Value
    $DestinationSQLCmd.Parameters.Clear()

    # Get Latest Record Id and Count from CLE
    $SrcConnStr = “Data Source=" + $sourceserver + ";Initial Catalog=" + $sourcedatabase + ";Integrated Security=False;user=" + $sourceuserid + ";pwd=" + $sourcepwd + ";Timeout = 0;"    
    #$SrcConnStr = “Data Source=" + $sourceserver + ";Initial Catalog=" + $sourcedatabase + ";Integrated Security=True;Timeout = 0;"    
    $SourceConnection  = New-Object System.Data.SqlClient.SQLConnection
    $SourceConnection.ConnectionString = $SrcConnStr  
    $SourceSQLCmd = New-Object System.Data.SqlClient.SqlCommand
    $SourceSQLCmd.CommandText = "dbo.prcGetVehicleEnquiryResponsesCount"
    $SourceSQLCmd.Connection = $SourceConnection
    $SourceSQLCmd.CommandType = [System.Data.CommandType]'StoredProcedure'
    
    $SourceSQLCmd.Parameters.AddWithValue("@PreviousHighWaterMark",$PreviousHighWaterMark)
    $OutputParm1 = $SourceSQLCmd.Parameters.AddWithValue("@HighWaterMark",$HighWaterMark)
    $OutputParm2 = $SourceSQLCmd.Parameters.AddWithValue("@RowCountSource",$RowCountSource)
    $OutputParm1.Direction = 'Output'
    $OutputParm2.Direction = 'Output'

    $SourceConnection.Open()
    $SourceSQLCmd.CommandTimeout = 0
    $SourceSQLCmd.ExecuteNonQuery()
    $HighWaterMark = $OutputParm1.Value
    $RowCountSource = $OutputParm2.Value
    $SourceSQLCmd.Parameters.Clear()

    if ($RowCountSource -gt 0) {

        # Insert Delta Log
        $DestinationSQLCmd.CommandText = "dbo.prcInsertDimDeltaLog"
        $DestinationSQLCmd.Parameters.AddWithValue("@ClientName",$clientname)
        $DestinationSQLCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
        $DestinationSQLCmd.Parameters.AddWithValue("@ObjectName","VehicleEnquiryResponses")
        $DestinationSQLCmd.Parameters.AddWithValue("@RowCountSource",$rowcountsource)
        $DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
        $OutputParm = $DestinationSQLCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
        $OutputParm.Direction = 'Output'
        $OutputParm.DbType = [System.Data.DbType]'String';
        $OutputParm.Size = 20
        $DestinationSQLCmd.ExecuteNonQuery()
        $DeltaLogKey = $OutputParm.Value
        $DestinationSQLCmd.Parameters.Clear()
 
        $SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
        $SourceSQLCmd.CommandText = "SELECT " 
        $SourceSQLCmd.CommandText += "VehicleEnquiryResponseRecordId,StorageTimestamp,MessageId,Timestamp,Notes,AreaAuthority,AreaAuthorityCode,AreaUserGroup,AreaUserGroupCode"
        $SourceSQLCmd.CommandText += ",BusinessOrSurname,DcceAddress,EconomicSector,EconomicSectorCode,IdDocumentNumber,IdDocumentType,IdDocumentTypeCode,Initials,Nationality"
        $SourceSQLCmd.CommandText += ",NationalityCode,NatureOfOwnership,NatureOfOwnershipCode,NatureOfPerson,NatureOfPersonCode,OwnershipStartDate,OwnershipStatus,OwnershipStatusCode"
        $SourceSQLCmd.CommandText += ",OwnershipType,OwnershipTypeCode,PersonNumber,PostalAddress,StreetAddress,VehicleUsage,VehicleUsageCode,CapacitySitting,CapacityStanding"
        $SourceSQLCmd.CommandText += ",Category,CategoryCode,CountryOfExport,CountryOfExportCode,DataOwner,DataOwnerCode,Description,DescriptionCode,DifferentialNumber,Driven"
        $SourceSQLCmd.CommandText += ",DrivenCode,EngineDisplacement,EngineNumber,FirstLicensingDate,FuelType,FuelTypeCode,GearboxNumber,GVM,LicenceChangeDate,LicenceExpiryDate"
        $SourceSQLCmd.CommandText += ",LicenceLiabilityDate,LicenceNumber,LicenceCertificateNumber,LifeStatus,LifeStatusCode,MainColour,MainColourCode,Make,MakeCode,MicrodotAppliedDate"
        $SourceSQLCmd.CommandText += ",MicrodotPin,MicrodotUserGroup,MicrodotUserGroupCode,ModelName,ModelNameCode,ModelNumber,NetPower,PrePreviousLicenceNumber,PreviousLicenceNumber"
        $SourceSQLCmd.CommandText += ",RegAuthorityOfLicensing,RegAuthorityOfLicensingCode,RegAuthorityOfRegistration,RegAuthorityOfRegistrationCode,RegistrationDate,RegistrationQualifier"
        $SourceSQLCmd.CommandText += ",RegistrationQualifierCode,RegistrationQualifierDate,RoadworthyStatus,RoadworthyStatusCode,RoadworthyTestDate,SapClearanceDate,SapClearanceReasonCodes"
        $SourceSQLCmd.CommandText += ",SapClearanceReasons,SapClearanceStatus,SapClearanceStatusCode,SapMark,SapMarkCode,SapMarkDate,Tare,Transmission,TransmissionCode,UnitNumber"
        $SourceSQLCmd.CommandText += ",VehicleRegisterNumber,VehicleState,VehicleStateCode,VehicleStateDate,VinOrChassis,Archived,SpeedClass"
        $SourceSQLCmd.CommandText += " FROM VehicleEnquiryResponses WITH (NOLOCK) WHERE VehicleEnquiryResponseRecordId between " + $PreviousHighWaterMark + " AND " + $HighWaterMark
        $SourceSQLCmd.CommandTimeout = 0 

        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection.ConnectionString, [System.Data.SqlClient.SqlBulkCopyOptions]::KeepIdentity)
        $bulkCopy.DestinationTableName = $schemaname + ".VehicleEnquiryResponses"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)

        # Update Delta Log Row
        $DestinationSQLCmd.CommandText = "dbo.prcUpdateDimDeltaLog" + $object
        $DestinationSQLCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
        $DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
        $DestinationSQLCmd.CommandTimeout = 0
        $DestinationSQLCmd.ExecuteNonQuery()
        $DestinationSQLCmd.Parameters.Clear()

    }

    # Update Audit row
    $DestinationSQLCmd.CommandText = "dbo.prcUpdateDimAudit"
    $DestinationSQLCmd.Parameters.Clear()
    $DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
    $DestinationSQLCmd.ExecuteNonQuery()

}
Catch
{

    # Save Exception Details
    $ExceptionMessage = $_.Exception.Message.Trim()
    $ExceptionLine = $_.InvocationInfo.Line.Trim()
    $ExectptionLineNo = $_.InvocationInfo.ScriptLineNumber

    # Update Execution Log with Exception Details and Close
    $DestinationSQLCmd.CommandText = "prcUpdateDimExecutionLog"
    $DestinationSQLCmd.Parameters.Clear()
    $DestinationSQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
    $DestinationSQLCmd.Parameters.AddWithValue("@ExceptionLineNo",$ExectptionLineNo)
    $DestinationSQLCmd.Parameters.AddWithValue("@ExceptionLine",$ExceptionLine)
    $DestinationSQLCmd.Parameters.AddWithValue("@ExceptionMessage",$ExceptionMessage)
    $DestinationSQLCmd.ExecuteNonQuery()

}
Finally
{

    # Close off Execution Log
    $DestinationSQLCmd.CommandText = "prcUpdateDimExecutionLog"
    $DestinationSQLCmd.Parameters.Clear()
    $DestinationSQLCmd.Parameters.AddWithValue("@ExecutionLogKey",$ExecutionLogKey)
    $DestinationSQLCmd.ExecuteNonQuery()

    $DestinationConnection.Close()

}