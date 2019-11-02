<# 
Script:  LoadStageAlertsBoot.ps1
Purpose: Loads history data from Alerts CLE
Author:  Trevor Howe
Date:    17 February 2018
#>

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
$DeltaString = ""
$object = "Alerts"
$UnloadedDeltas = @()

$scriptname = "LoadStageAlertsBoot.ps1"       
$StageTable = "[" + $schemaname + "].[" + $object + "]"

# Create Audit row 
$DestinationConnection = New-Object System.Data.SqlClient.SqlConnection
$DestinationConnection.ConnectionString = "Server= $wcgserver ;Database= $wcgstagedb ;Integrated Security=True"
$DestinationSQLCmd = New-Object System.Data.SqlClient.SqlCommand

$DestinationSQLCmd.CommandText = "dbo.prcInsertDimAudit"
$DestinationSQLCmd.Connection = $DestinationConnection
$DestinationSQLCmd.CommandType = [System.Data.CommandType]'StoredProcedure'
    
$DestinationSQLCmd.Parameters.AddWithValue("@ClientName",$clientname)
$DestinationSQLCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
$DestinationSQLCmd.Parameters.AddWithValue("@TableName",$object)
$DestinationSQLCmd.Parameters.AddWithValue("@ScriptName",$scriptname)
$OutputParm = $DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$auditkey)
$OutputParm.Direction = 'Output'

$DestinationConnection.Open()
$DestinationSQLCmd.ExecuteNonQuery()
$auditkey = $OutputParm.Value
$DestinationSQLCmd.Parameters.Clear()

$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.Connection = $DestinationConnection
$SqlCmd.CommandType = [System.Data.CommandType]'Text'

# Get Unloaded Deltas
$SqlCmd.CommandText = "SELECT CONCAT(FromId,';',ToId,';',RowCountSource) AS DeltaString FROM WCG_Stage.dbo.AlertsDeltas ORDER BY LogDate"
$SqlDataReader = $SqlCmd.ExecuteReader()

# For each unloaded Delta run Load Stored Procedure
while ($SqlDataReader.Read())
{
    $DeltaString = $SqlDataReader["DeltaString"]
    $UnloadedDeltas += $DeltaString
}
$SqlDataReader.Close()

#$SrcConnStr = “Data Source=" + $sourceserver + ";Initial Catalog=" + $sourcedatabase + ";Integrated Security=False;user=" + $sourceuserid + ";pwd=" + $sourcepwd + ";Timeout = 0;"    
$SrcConnStr = “Data Source=" + $sourceserver + ";Initial Catalog=" + $sourcedatabase + ";Integrated Security=True;Timeout = 0;"    
$SourceConnection  = New-Object System.Data.SqlClient.SQLConnection
$SourceConnection.ConnectionString = $SrcConnStr  
$SourceSQLCmd = New-Object System.Data.SqlClient.SqlCommand
$SourceSQLCmd.Connection = $SourceConnection
$SourceSQLCmd.CommandType = [System.Data.CommandType]'Text'
$SourceConnection.Open()


# For each unloaded Delta run Load Stored Procedure
foreach ($DeltaString in $UnloadedDeltas)
{
    $PreviousHighWaterMark, $HighWaterMark, $RowCountSource = $DeltaString.Split(";")
    
    if ($RowCountSource -gt 0) {

        # Insert Delta Log
        $DestinationSQLCmd.CommandText = "dbo.prcInsertDimDeltaLog"
        $DestinationSQLCmd.Parameters.AddWithValue("@ClientName",$clientname)
        $DestinationSQLCmd.Parameters.AddWithValue("@SchemaName",$schemaname)
        $DestinationSQLCmd.Parameters.AddWithValue("@ObjectName",$object)
        $DestinationSQLCmd.Parameters.AddWithValue("@RowCountSource",$rowcountsource)
        $DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
        $OutputParm = $DestinationSQLCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
        $OutputParm.Direction = 'Output'
        $OutputParm.DbType = [System.Data.DbType]'String';
        $OutputParm.Size = 20
        $DestinationSQLCmd.ExecuteNonQuery()
        $DeltaLogKey = $OutputParm.Value
        $DestinationSQLCmd.Parameters.Clear()
 
        $SourceSQLCmd.CommandText = "SELECT " 
		$SourceSQLCmd.CommandText += "AlertRecordId,StorageDate,VRN,AlertDateTime,AlertId,SourceSystemId,UserId,AlertStatus,AlertStatusDescription,AlertType,AlertTypeId"
		$SourceSQLCmd.CommandText += ",AlertSubType,AlertSubTypeCode,Latitude,Longitude,SightingId,AverageKmh,DeviceId,Lane,LaneDirectionCode,LicenceNumber,MainColour"
		$SourceSQLCmd.CommandText += ",MainColourCode,Make,MakeCode,ModelName,ModelNameCode,PrimarySightingDateTime,PrimarySightingId,PrimaryInfraredImageFormat"
		$SourceSQLCmd.CommandText += ",PrimaryOverviewImageFormat,PrimarySiteName,RoadSection,SecondarySightingDateTime,SecondarySightingId,SecondaryInfraredImageFormat"
		$SourceSQLCmd.CommandText += ",SecondaryOverviewImageFormat,SecondarySiteName,SpeedLimit,VehicleCategory,VehicleCategoryCode,VehicleDirectionCode,VehicleSpeedClass"
		$SourceSQLCmd.CommandText += ",VehicleSpeedClassCode,VehicleUsage,VehicleUsageCode,IsIgnoredForS341"
        $SourceSQLCmd.CommandText += " FROM Alerts WITH (NOLOCK) WHERE AlertRecordId between " + $PreviousHighWaterMark + " AND " + $HighWaterMark
        $SourceSQLCmd.CommandTimeout = 0 

        [System.Data.SqlClient.SqlDataReader] $SqlReader = $SourceSQLCmd.ExecuteReader()
    
        $bulkCopy = New-Object Data.SqlClient.SqlBulkCopy($DestinationConnection.ConnectionString, [System.Data.SqlClient.SqlBulkCopyOptions]::KeepIdentity)
        $bulkCopy.DestinationTableName = $schemaname + ".Alerts"
        $bulkcopy.BulkCopyTimeout = 0
        $bulkCopy.WriteToServer($SqlReader)
        $SqlReader.Close()
        
        # Update Delta Log Row
        $DestinationSQLCmd.CommandText = "dbo.prcUpdateDimDeltaLog" + $object
        $DestinationSQLCmd.Parameters.AddWithValue("@DeltaLogKey",$DeltaLogKey)
        $DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
        $DestinationSQLCmd.CommandTimeout = 0
        $DestinationSQLCmd.ExecuteNonQuery()
        $DestinationSQLCmd.Parameters.Clear()

    }
}

# Update Audit row
$DestinationSQLCmd.CommandText = "dbo.prcUpdateDimAudit"
$DestinationSQLCmd.Parameters.AddWithValue("@AuditKey",$AuditKey)
$DestinationSQLCmd.ExecuteNonQuery()
$SourceConnection.Close()
$DestinationConnection.Close()

