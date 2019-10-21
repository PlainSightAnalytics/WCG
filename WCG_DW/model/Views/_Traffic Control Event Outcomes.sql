
CREATE VIEW [model].[_Traffic Control Event Outcomes] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactTrafficControlEventOutcomes
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [DeviceKey] AS [DeviceKey]
	,[DriverKey] AS [DriverKey]
	,[MagistratesCourtKey] AS [MagistratesCourtKey]
	,[OpenDateKey] AS [OpenDateKey]
	,[OpenTimeKey] AS [OpenTimeKey]
	,[OperationKey] AS [OperationKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[Section56FormKey] AS [Section56FormKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[TrafficControlEventKey] AS [TrafficControlEventKey]
	,[UpdatedDateKey] AS [UpdatedDateKey]
	,[UpdatedTimeKey] AS [UpdatedTimeKey]
	,[UserKey] AS [UserKey]
	,[VehicleKey] AS [VehicleKey]
	,[VehicleTypeKey] AS [VehicleTypeKey]
	,[ViolationChargeKey] AS [ViolationChargeKey]
	,[UniqueChargeID] AS [Unique Charge ID]
	,[UniqueSection56FormID] AS [Unique Section 5 6 Form ID]
	,[ChargeAmount] AS [_ChargeAmount]
	,[DeltaLogKey] AS [DeltaLogKey]
FROM WCG_DW.dbo.FactTrafficControlEventOutcomes WITH (NOLOCK)
