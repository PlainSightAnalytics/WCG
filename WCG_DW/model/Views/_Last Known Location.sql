



CREATE VIEW [model].[_Last Known Location] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   28-05-2018
-- Reason               :   Semantic View for Last Known Location
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH CTE as 
(
	SELECT f.DeviceKey
		  ,d1.Latitude
		  ,d1.Longitude
		  ,f.UpdatedDateKey
		  ,f.UserKey
		  ,f.TrafficCentreKey
		  ,DATEADD(MINUTE,(d4.Hour24*60) + d4.MinuteOfHour,CAST(d3.FullDate AS SMALLDATETIME)) AS LastUsedDateTime
		  ,ROW_NUMBER() OVER (PARTITION BY f.[UserKey] ORDER BY f.[UpdatedDateKey] DESC, f.UpdatedTimeKey DESC) AS RowSequence
	FROM FactTrafficControlEvents f WITH (NOLOCK)
	LEFT JOIN DimTrafficControlEvent d1 WITH (NOLOCK) ON d1.TrafficControlEventKey = f.TrafficControlEventKey
	LEFT JOIN DimDevice d2 WITH (NOLOCK) ON d2.DeviceKey = f.DeviceKey
	LEFT JOIN DimDate d3 WITH (NOLOCK) ON f.UpdatedDateKey = d3.DateKey
	LEFT JOIN DimTime d4 WITH (NOLOCK) ON f.UpdatedTimeKey = d4.TimeKey
	WHERE d1.Latitude <> 0
	AND d1.Longitude <> 0
	AND f.UserKey <> -1
	AND f.DeviceKey <> -1
)

SELECT
	DeviceKey
	,UserKey
	,TrafficCentreKey
	,UpdatedDateKey
	,Latitude
	,Longitude
	,LastUsedDateTime
FROM CTE
WHERE RowSequence = 1

