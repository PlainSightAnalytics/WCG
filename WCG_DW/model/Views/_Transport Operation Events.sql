


CREATE VIEW [model].[_Transport Operation Events] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   04-10-2019
-- Reason               :   Transport Operation Events (Land Transport Survey, Road Safety, EMS)
------------------------------------------------------------------------------------------
-- Modified By          :	
-- Modified On          :	
-- Reason               :	
------------------------------------------------------------------------------------------

WITH DriverVehicleCTE AS (
SELECT
	 FORMAT(d3.EventOpenDateTime,'yyyyMMdd')	AS OpenDateKey
	,d4.TrafficCentre							AS RelatedTrafficCentre
	,f.TrafficControlEventKey					AS TrafficControlEventKey
	,d5.[User]									AS RelatedUser
	,d1.IDDocumentNo							AS IDDocumentNo
	,d2.RegistrationNo							AS RegistrationNo
	,d3.EventOpenDateTime						AS EventOpenDateTime
FROM FactTrafficControlEvents f WITH (NOLOCK)
LEFT JOIN DimDriver d1 WITH (NOLOCK) ON f.DriverKey = d1.DriverKey
LEFT JOIN DimVehicle d2	WITH (NOLOCK) ON f.VehicleKey = d2.VehicleKey
LEFT JOIN DimTrafficControlEvent d3 WITH (NOLOCK) ON f.TrafficControlEventKey = d3.TrafficControlEventKey
LEFT JOIN DimTrafficCentre d4 WITH (NOLOCK) ON f.TrafficCentreKey = d4.TrafficCentreKey
LEFT JOIN DimUser d5 WITH (NOLOCK) ON f.UserKey = d5.UserKey
WHERE 
	NOT (f.DriverKey = -1 AND f.VehicleKey = -1)
	AND NOT (
		LandTransportSurveyRepresentative <> 'Not Applicable'
	 OR EMSRepresentative <> 'Not Applicable'
	 OR RoadSafetyRepresentative <> 'Not Applicable'
	 OR HeartRate IS NOT NULL
	 OR BloodGlucoseLevel IS NOT NULL
	 OR BloodPressureDiastolic IS NOT NULL
	 OR BloodPressureSystolic IS NOT NULL
	 OR EMSComments IS NOT NULL
	 OR RoadSafetyCompletedDateTime IS NOT NULL
	)
)


,CTE AS (
SELECT 
	 f.AlertTypeKey
	,f.DeviceKey
	,f.DriverKey
	,f.MagistratesCourtKey
	,f.OpenDateKey
	,f.OpenTimeKey
	,f.OperationKey
	,f.OperationsDateKey
	,f.TrafficCentreKey
	,f.TrafficControlEventKey
	,f.UpdatedDateKey
	,f.UpdatedTimeKey
	,f.UserKey
	,f.VehicleKey
	,f.VehicleTypeKey
	,CASE
		WHEN LandTransportSurveyRepresentative <> 'Not Applicable' THEN 'Yes'
		ELSE 'No'
	END AS LandTransportSurveyFlag
	,CASE
		WHEN (  EMSRepresentative = 'Not Applicable'
			AND HeartRate IS NULL
			AND BloodGlucoseLevel IS NULL
			AND BloodPressureDiastolic IS NULL
			AND BloodPressureSystolic IS NULL
			AND EMSTestingStatus = 'Not Tested'
			) THEN 'No'
		WHEN (  HeartRate IS NULL
			AND BloodGlucoseLevel IS NULL
			AND BloodPressureDiastolic IS NULL
			AND BloodPressureSystolic IS NULL
			AND EMSTestingStatus = 'Tested'
			) THEN 'No'
		ELSE 'Yes'
	END AS EMSFlag 
	,CASE
		WHEN (
			 RoadSafetyRepresentative = 'Not Applicable'
		 AND RoadSafetyCompletedDateTime IS NULL) THEN 'No'
		 ELSE 'Yes'
	END AS RoadSafetyFlag
	,COALESCE(d.RelatedTrafficCentre, v.RelatedTrafficCentre, d6.TrafficCentre) AS RelatedTrafficCentre
	,COALESCE(d.RelatedUser, v.RelatedUser,d5.[User]) AS RelatedUser
	,ROW_NUMBER() OVER (
		PARTITION BY f.TrafficControlEventKey 
		ORDER BY	ABS(
						DATEDIFF(SECOND, d1.EventOpenDateTime,
							ISNULL(d.EventOpenDateTime,v.EventOpenDateTime)
						)
					)	
				) AS RowSequence
FROM FactTrafficControlEvents f WITH (NOLOCK)
LEFT JOIN DimTrafficControlEvent d1 WITH (NOLOCK) ON f.TrafficControlEventKey = d1.TrafficControlEventKey
LEFT JOIN DimVehicle d2 WITH (NOLOCK) ON f.VehicleKey = d2.VehicleKey
LEFT JOIN DimDriver d3 WITH (NOLOCK) ON f.DriverKey = d3.DriverKey
LEFT JOIN DimUser d5 WITH (NOLOCK) on f.UserKey = d5.UserKey
LEFT JOIN DimTrafficCentre d6 WITH (NOLOCK) ON f.TrafficCentreKey = d6.TrafficCentreKey
LEFT JOIN DriverVehicleCTE d ON d3.IDDocumentNo = d.IDDocumentNo AND f.OpenDateKey = d.OpenDateKey AND f.TrafficControlEventKey <> d.TrafficControlEventKey AND f.DriverKey <> -1
LEFT JOIN DriverVehicleCTE v ON d2.RegistrationNo = v.RegistrationNo AND f.OpenDateKey = v.OpenDateKey AND f.TrafficControlEventKey <> v.TrafficControlEventKey AND f.VehicleKey <> -1
WHERE 
 NOT
	(
		LandTransportSurveyRepresentative = 'Not Applicable'
	 AND EMSRepresentative = 'Not Applicable'
	 AND EMSTestingStatus = 'Not Tested' 
	 AND RoadSafetyRepresentative = 'Not Applicable'
	 AND HeartRate IS NULL
	 AND BloodGlucoseLevel IS NULL
	 AND BloodPressureDiastolic IS NULL
	 AND BloodPressureSystolic IS NULL
	 AND EMSComments IS NULL
	 AND RoadSafetyCompletedDateTime IS NULL
	)
)

SELECT 
	 cte.AlertTypeKey
	,cte.DeviceKey
	,cte.DriverKey
	,cte.MagistratesCourtKey
	,cte.OpenDateKey
	,cte.OpenTimeKey
	,cte.OperationKey
	,cte.OperationsDateKey
	,cte.TrafficCentreKey
	,cte.TrafficControlEventKey
	,cte.UpdatedDateKey
	,cte.UpdatedTimeKey
	,cte.UserKey
	,cte.VehicleKey
	,cte.VehicleTypeKey
	,cte.RelatedTrafficCentre
	,cte.RelatedUser
	,cte.LandTransportSurveyFlag
	,cte.EMSFlag
	,cte.RoadSafetyFlag
FROM cte
WHERE 
	RowSequence = 1
	AND (LandTransportSurveyFlag = 'Yes' OR EMSFlag = 'Yes' OR RoadSafetyFlag = 'Yes')

