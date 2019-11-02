



CREATE VIEW [model].[_Operation Sightings] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   16-09-2019
-- Reason               :   Semantic View for Operation Sightings
------------------------------------------------------------------------------------------
-- Modified By          :	
-- Modified On          :	
-- Reason               :	
------------------------------------------------------------------------------------------

WITH MobileCameraCTE AS (
SELECT 
	 CameraKey
	,REPLACE(REPLACE(CameraID,'REAR',''),'FRONT','') AS RegistrationNo
FROM WCG_DW.dbo.DimCamera WITH (NOLOCK)
WHERE IsMobileCamera = 'Yes'
)

,MobileOperationCTE AS (
SELECT
	 c.CameraKey
	,o.OperationKey
	,o.ActualStartTime
	,o.ActualStopTime
	,o.SightingVehicleRegistrationNo
	,o.OperationStatus
	,f.TrafficCentreKey
FROM WCG_DW.dbo.FactPlannedOperations f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimOperation o		WITH (NOLOCK) ON f.OperationKey = o.OperationKey
LEFT JOIN MobileCameraCTE c				WITH (NOLOCK) ON o.SightingVehicleRegistrationNo = c.RegistrationNo
WHERE 
	SightingVehicleRegistrationNo <> 'Not Applicable'
AND o.OperationSubType <> 'ASOD'
AND o.ActualStartTime IS NOT NULL
AND o.ActualStopTime IS NOT NULL
AND o.OperationStatus = 'Approved'
)

,ASODOperationCTE AS (
SELECT 
	 c.CameraKey
	,o.OperationKey
	,o.ActualStartTime
	,o.ActualStopTime
	,o.OperationStatus
	,f.TrafficCentreKey
FROM WCG_DW.dbo.FactPlannedOperations f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimOperation o		WITH (NOLOCK) ON f.OperationKey = o.OperationKey
LEFT JOIN WCG_DW.dbo.DimCamera c		WITH (NOLOCK) ON o.ASODRoadSection = c.SpeedSection
WHERE 
	o.ASODRoadSection <> 'Not Applicable'
AND o.OperationSubType = 'ASOD'
AND o.ActualStartTime IS NOT NULL
AND o.ActualStopTime IS NOT NULL
AND o.OperationStatus = 'Approved'
)

,OperationCTE AS (
SELECT
	 CameraKey
	,OperationKey
	,ActualStartTime
	,ActualStopTime
	,TrafficCentreKey
FROM MobileOperationCTE
UNION ALL
SELECT
	 CameraKey
	,OperationKey
	,ActualStartTime
	,ActualStopTime
	,TrafficCentreKey
FROM ASODOperationCTE
)

SELECT 
	 f.CameraKey
	,f.GeoLocationKey
	,f.OperationsDateKey
	,f.SightingDateKey
	,f.SightingTimeKey
	,o.TrafficCentreKey
	,f.VehicleKey
	,f.PartyKey
	,f.SightingRecordId
	,o.OperationKey
FROM WCG_DW.dbo.FactSightings f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimDate d1 ON f.SightingDateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimTime d2 ON f.SightingTimeKey = d2.TimeKey
INNER JOIN OperationCTE o on f.CameraKey = o.CameraKey AND CAST(d1.FullDATE AS DATETIME) + CAST(d2.FullTime AS DATETIME) BETWEEN o.ActualStartTime AND o.ActualStopTime



