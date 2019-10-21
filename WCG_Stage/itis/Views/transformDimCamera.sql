










CREATE VIEW [itis].[transformDimCamera] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-08-2016
-- Reason				:	Transform view for Camera
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	27-12-2018
-- Reason				:	Added new attributes for Route, RouteSequence and DistanceFromPreviousCamera
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 c.id													AS CameraGUID
	,CAST(
		CASE
			WHEN c.location_name like '%Lane%' THEN ISNULL(c.camera_id_number,'UNKNOWN')
			WHEN c.site_id_number IS NULL AND c.lane_id_number IS NULL THEN REPLACE(UPPER(c.location_name),' ','')
			ELSE ISNULL(c.camera_id_number,'UNKNOWN')
		END AS VARCHAR(20))									AS CameraId
	,CAST(
		CASE
			WHEN site_id_number = '1'  THEN 'Yzerfontein'
			WHEN site_id_number = '2'  THEN 'Buffelsfontein'
			WHEN site_id_number = '3'  THEN 'Ganzekraal'
			WHEN site_id_number = '4'  THEN 'Waschklip'
			WHEN site_id_number = '5'  THEN 'Leeu-Gamka'
			WHEN site_id_number = '6'  THEN 'Aberdeen'
			WHEN site_id_number = '7'  THEN 'Beaufort West - North'
			WHEN site_id_number = '8'  THEN 'Beaufort West - East'
			WHEN site_id_number = '9'  THEN 'Karoo National Park'
			WHEN site_id_number = '10' THEN 'Riemhoogte'
			WHEN site_id_number = '11' THEN 'Dwyka'
			WHEN site_id_number = '12' THEN 'Laingsburg'
			WHEN site_id_number = '13' THEN 'Baviaan'
			WHEN site_id_number = '14' THEN 'Quarry'
			WHEN site_id_number = '15' THEN 'Pienaarskloof'
			WHEN site_id_number = '16' THEN 'Elandskloof'
			WHEN site_id_number = '17' THEN 'Steenbras'
			WHEN site_id_number = '18' THEN 'Houwhoek'
			ELSE 'Mobile'
		END	AS VARCHAR(30))									AS CameraLocation
	,CAST(
		COALESCE(c.location_description,c.location_name,'Unknown')
		AS VARCHAR(30))										AS CameraName
	,CAST(
		CASE
			WHEN lane_id_number = '1' AND site_id_number = '1'   THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '1'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '2'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '2'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '3'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '4'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '5'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '5'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '6'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '6'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '7'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '8'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '9'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '10'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '10'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '11'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '11'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '12'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '13'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '14'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '14'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '15'	 THEN 'No'
			WHEN lane_id_number = '1' AND site_id_number = '16'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '16'	 THEN 'No'
			WHEN lane_id_number = '2' AND site_id_number = '17'	 THEN 'No'
			ELSE 'Yes'
		END	AS VARCHAR(3))									AS IsCountedInReport
	,CAST(
		CASE
			WHEN c.location_name like '%Lane%' THEN 'No'
			WHEN c.site_id_number IS NULL AND c.lane_id_number IS NULL THEN 'Yes'
			ELSE 'No'
		END	AS VARCHAR(3))									AS IsMobileCamera
	,c.operational_area_id									AS OperationalAreaGUID
	,CAST(ISNULL(o.name,'Unknown') AS VARCHAR(50))			AS OperationalArea
	,CAST(ISNULL(c.lane_id_number,0) AS VARCHAR(50))		AS LaneId
	,CAST(ISNULL(c.site_id_number,0) AS VARCHAR(50))		AS SiteId
	,CAST(
		CASE
			WHEN site_id_number = '6' AND lane_id_number= '2' THEN 'Aberdeen - Beaufort West'
			WHEN site_id_number = '10' AND lane_id_number= '2' THEN 'Riemhoogte - Beaufort West'
			WHEN site_id_number = '8' AND lane_id_number= '2' THEN 'Aberdeen - Beaufort West'
			WHEN site_id_number = '7' AND lane_id_number= '2' THEN 'Riemhoogte - Beaufort West'
			WHEN site_id_number = '9' AND lane_id_number= '2' THEN 'Beaufort West - Leeu Gamka'
			WHEN site_id_number = '5' AND lane_id_number= '2' THEN 'Beaufort West - Leeu Gamka'
			WHEN site_id_number = '11' AND lane_id_number= '2' THEN 'Leeu Gamka - Dwyka'
			WHEN site_id_number = '12' AND lane_id_number= '2' THEN 'Dwyka - Laingsburg'
			WHEN site_id_number = '13' AND lane_id_number= '2' THEN 'Laingsburg - Baviaan'
			WHEN site_id_number = '14' AND lane_id_number= '2' THEN 'Baviaan - Quarry'
			WHEN site_id_number = '15' AND lane_id_number= '2' THEN 'Quarry - Pienaarskloof'
			WHEN site_id_number = '15' AND lane_id_number= '1' THEN 'Pienaarskloof - Quarry'
			WHEN site_id_number = '14' AND lane_id_number= '1' THEN 'Pienaarskloof - Quarry'
			WHEN site_id_number = '13' AND lane_id_number= '1' THEN 'Quarry - Baviaan'
			WHEN site_id_number = '12' AND lane_id_number= '1' THEN 'Baviaan - Laingsburg'
			WHEN site_id_number = '11' AND lane_id_number= '1' THEN 'Laingsburg - Dwyka'
			WHEN site_id_number = '5' AND lane_id_number= '1' THEN 'Dwyka - Leeu Gamka'
			WHEN site_id_number = '9' AND lane_id_number= '1' THEN 'Leeu Gamka - Beaufort West'
			WHEN site_id_number = '8' AND lane_id_number= '1' THEN 'Leeu Gamka - Beaufort West'
			WHEN site_id_number = '7' AND lane_id_number= '1' THEN 'Leeu Gamka - Beaufort West'
			WHEN site_id_number = '6' AND lane_id_number= '1' THEN 'Beaufort West  - Aberdeen'
			WHEN site_id_number = '10' AND lane_id_number= '1' THEN 'Beaufort West - Riemhoogte'
			WHEN site_id_number = '18' AND lane_id_number= '2' THEN 'Houwhoek - Steenbras'
			WHEN site_id_number = '17' AND lane_id_number= '2' THEN 'Houwhoek - Steenbras'
			WHEN site_id_number = '16' AND lane_id_number= '3' THEN 'Steenbras - Elandskloof'
			WHEN site_id_number = '16' AND lane_id_number= '1' THEN 'Steenbras - Elandskloof'
			WHEN site_id_number = '16' AND lane_id_number= '2' THEN 'Steenbras - Elandskloof'
			WHEN site_id_number = '17' AND lane_id_number= '1' THEN 'Elandskloof - Steenbras'
			WHEN site_id_number = '18' AND lane_id_number= '1' THEN 'Steenbras - Houwhoek'
			WHEN site_id_number = '4' AND lane_id_number= '2' THEN 'Waschklip - Buffelsfontein'
			WHEN site_id_number = '2' AND lane_id_number= '2' THEN 'Waschklip - Buffelsfontein'
			WHEN site_id_number = '1' AND lane_id_number= '2' THEN 'Buffelsfontein - Yzerfontein'
			WHEN site_id_number = '3' AND lane_id_number= '2' THEN 'Yzerfontein - Ganzekraal'
			WHEN site_id_number = '3' AND lane_id_number= '1' THEN 'Ganzekraal - Yzerfontein'
			WHEN site_id_number = '1' AND lane_id_number= '1' THEN 'Ganzekraal - Yzerfontein'
			WHEN site_id_number = '2' AND lane_id_number= '1' THEN 'Yzerfontein - Buffelsfontein'
			WHEN site_id_number = '4' AND lane_id_number= '1' THEN 'Buffelsfontein - Waschklip'
			ELSE 'Not Applicable'
		END AS VARCHAR(50))									AS SpeedSection
	,CAST(NULL AS VARCHAR(100))								AS SpeedSectionDescription
	,CAST(NULL AS NUMERIC(11,2))							AS SpeedSectionDistance
	,CAST(NULL AS VARCHAR(10))								AS SpeedSectionPoint
	,c.traffic_centre_id									AS TrafficCentreGUID
	,CAST(ISNULL(t.name,'Unknown') AS VARCHAR(50))			AS TrafficCentre
	,CAST(
		CASE
			WHEN c.camera_id_number IS NOT NULL THEN 
				CASE
					WHEN site_id_number = '9' AND lane_id_number= '1' THEN 'North'
					WHEN site_id_number = '9' AND lane_id_number= '2' THEN 'South'
					WHEN site_id_number = '8' AND lane_id_number= '1' THEN 'North'
					WHEN site_id_number = '8' AND lane_id_number= '2' THEN 'South'
					WHEN site_id_number = '7' AND lane_id_number= '1' THEN 'North'
					WHEN site_id_number = '7' AND lane_id_number= '2' THEN 'South'
					WHEN site_id_number = '6' AND lane_id_number= '1' THEN 'North'
					WHEN site_id_number = '6' AND lane_id_number= '2' THEN 'South'
					WHEN site_id_number = '10' AND lane_id_number = '1' THEN 'North'
					WHEN site_id_number = '10' AND lane_id_number = '2' THEN 'South'
					WHEN RIGHT(c.location_name_short,1) = 'N' THEN 'North'
					WHEN RIGHT(c.location_name_short,1) = 'S' THEN 'South'
					WHEN RIGHT(c.location_name_short,1) = 'E' THEN 'East'
					WHEN RIGHT(c.location_name_short,1) = 'W' THEN 'West'
					ELSE 'Unknown'
				END
			ELSE 'Mobile' 
		END	AS VARCHAR(10))									AS TravelDirection
	,CASE
		WHEN site_id_number = '1' AND lane_id_number = '1' THEN 22.195
		WHEN site_id_number = '1' AND lane_id_number = '2' THEN 15.025
		WHEN site_id_number = '10' AND lane_id_number = '1' THEN 32.871
		WHEN site_id_number = '10' AND lane_id_number = '2' THEN 0
		WHEN site_id_number = '11' AND lane_id_number = '1' THEN 66.059
		WHEN site_id_number = '11' AND lane_id_number = '2' THEN 62.083
		WHEN site_id_number = '12' AND lane_id_number = '1' THEN 9.931
		WHEN site_id_number = '12' AND lane_id_number = '2' THEN 66.059
		WHEN site_id_number = '13' AND lane_id_number = '1' THEN 54.947
		WHEN site_id_number = '13' AND lane_id_number = '2' THEN 9.931
		WHEN site_id_number = '14' AND lane_id_number = '1' THEN 17.2
		WHEN site_id_number = '14' AND lane_id_number = '2' THEN 54.947
		WHEN site_id_number = '15' AND lane_id_number = '1' THEN 0
		WHEN site_id_number = '15' AND lane_id_number = '2' THEN 17.2
		WHEN site_id_number = '16' AND lane_id_number = '1' THEN 0
		WHEN site_id_number = '16' AND lane_id_number = '2' THEN 0
		WHEN site_id_number = '16' AND lane_id_number = '3' THEN 6.918
		WHEN site_id_number = '17' AND lane_id_number = '1' THEN 6.92
		WHEN site_id_number = '17' AND lane_id_number = '2' THEN 21.898
		WHEN site_id_number = '18' AND lane_id_number = '1' THEN 21.898
		WHEN site_id_number = '18' AND lane_id_number = '2' THEN 0
		WHEN site_id_number = '2' AND lane_id_number = '1' THEN 15.025
		WHEN site_id_number = '2' AND lane_id_number = '2' THEN 20.178
		WHEN site_id_number = '3' AND lane_id_number = '1' THEN 0
		WHEN site_id_number = '3' AND lane_id_number = '2' THEN 22.195
		WHEN site_id_number = '4' AND lane_id_number = '1' THEN 20.178
		WHEN site_id_number = '4' AND lane_id_number = '2' THEN 0
		WHEN site_id_number = '5' AND lane_id_number = '1' THEN 62.083
		WHEN site_id_number = '5' AND lane_id_number = '2' THEN 62.413
		WHEN site_id_number = '6' AND lane_id_number = '1' THEN 71.71
		WHEN site_id_number = '6' AND lane_id_number = '2' THEN 0
		WHEN site_id_number = '7' AND lane_id_number = '1' THEN 6.5
		WHEN site_id_number = '7' AND lane_id_number = '2' THEN 32.871
		WHEN site_id_number = '8' AND lane_id_number = '1' THEN 6.5
		WHEN site_id_number = '8' AND lane_id_number = '2' THEN 71.71
		WHEN site_id_number = '9' AND lane_id_number = '1' THEN 62.413
		WHEN site_id_number = '9' AND lane_id_number = '2' THEN 6.5
		ELSE 0
	END AS DistanceFromPreviousCamera
	,CASE
		WHEN c.site_id_number IS NULL AND c.lane_id_number IS NULL THEN 'Mobile'
		WHEN site_id_number = '3' AND lane_id_number = '1' THEN 'R27 Outbound'
		WHEN site_id_number = '4' AND lane_id_number = '2' THEN 'R27 Inbound'
		WHEN site_id_number = '16' AND lane_id_number = '1' THEN 'N2 Outbound'
		WHEN site_id_number = '18' AND lane_id_number = '2' THEN 'N2 Inbound'
		WHEN site_id_number = '10' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '15' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '6' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '1' AND lane_id_number = '1' THEN 'R27 Outbound'
		WHEN site_id_number = '2' AND lane_id_number = '2' THEN 'R27 Inbound'
		WHEN site_id_number = '17' AND lane_id_number = '1' THEN 'N2 Outbound'
		WHEN site_id_number = '17' AND lane_id_number = '2' THEN 'N2 Inbound'
		WHEN site_id_number = '14' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '7' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '8' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '1' AND lane_id_number = '2' THEN 'R27 Inbound'
		WHEN site_id_number = '2' AND lane_id_number = '1' THEN 'R27 Outbound'
		WHEN site_id_number = '16' AND lane_id_number = '2' THEN 'N2 Outbound'
		WHEN site_id_number = '16' AND lane_id_number = '3' THEN 'N2 Inbound'
		WHEN site_id_number = '18' AND lane_id_number = '1' THEN 'N2 Outbound'
		WHEN site_id_number = '13' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '9' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '3' AND lane_id_number = '2' THEN 'R27 Inbound'
		WHEN site_id_number = '4' AND lane_id_number = '1' THEN 'R27 Outbound'
		WHEN site_id_number = '12' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '5' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '11' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '11' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '12' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '5' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '13' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '9' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '14' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '7' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '8' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '10' AND lane_id_number = '1' THEN 'N1 Outbound'
		WHEN site_id_number = '15' AND lane_id_number = '2' THEN 'N1 Inbound'
		WHEN site_id_number = '6' AND lane_id_number = '1' THEN 'N1 Outbound'
		ELSE ''
	END AS Route
	,CASE
		WHEN site_id_number = '1' AND lane_id_number = '1' THEN 2
		WHEN site_id_number = '1' AND lane_id_number = '2' THEN 3
		WHEN site_id_number = '10' AND lane_id_number = '1' THEN 9
		WHEN site_id_number = '10' AND lane_id_number = '2' THEN 1
		WHEN site_id_number = '11' AND lane_id_number = '1' THEN 5
		WHEN site_id_number = '11' AND lane_id_number = '2' THEN 5
		WHEN site_id_number = '12' AND lane_id_number = '1' THEN 4
		WHEN site_id_number = '12' AND lane_id_number = '2' THEN 6
		WHEN site_id_number = '13' AND lane_id_number = '1' THEN 3
		WHEN site_id_number = '13' AND lane_id_number = '2' THEN 7
		WHEN site_id_number = '14' AND lane_id_number = '1' THEN 2
		WHEN site_id_number = '14' AND lane_id_number = '2' THEN 8
		WHEN site_id_number = '15' AND lane_id_number = '1' THEN 1
		WHEN site_id_number = '15' AND lane_id_number = '2' THEN 9
		WHEN site_id_number = '16' AND lane_id_number = '1' THEN 1
		WHEN site_id_number = '16' AND lane_id_number = '2' THEN 1
		WHEN site_id_number = '16' AND lane_id_number = '3' THEN 3
		WHEN site_id_number = '17' AND lane_id_number = '1' THEN 2
		WHEN site_id_number = '17' AND lane_id_number = '2' THEN 2
		WHEN site_id_number = '18' AND lane_id_number = '1' THEN 3
		WHEN site_id_number = '18' AND lane_id_number = '2' THEN 1
		WHEN site_id_number = '2' AND lane_id_number = '1' THEN 3
		WHEN site_id_number = '2' AND lane_id_number = '2' THEN 2
		WHEN site_id_number = '3' AND lane_id_number = '1' THEN 1
		WHEN site_id_number = '3' AND lane_id_number = '2' THEN 4
		WHEN site_id_number = '4' AND lane_id_number = '1' THEN 4
		WHEN site_id_number = '4' AND lane_id_number = '2' THEN 1
		WHEN site_id_number = '5' AND lane_id_number = '1' THEN 6
		WHEN site_id_number = '5' AND lane_id_number = '2' THEN 4
		WHEN site_id_number = '6' AND lane_id_number = '1' THEN 9
		WHEN site_id_number = '6' AND lane_id_number = '2' THEN 1
		WHEN site_id_number = '7' AND lane_id_number = '1' THEN 8
		WHEN site_id_number = '7' AND lane_id_number = '2' THEN 2
		WHEN site_id_number = '8' AND lane_id_number = '1' THEN 8
		WHEN site_id_number = '8' AND lane_id_number = '2' THEN 2
		WHEN site_id_number = '9' AND lane_id_number = '1' THEN 7
		WHEN site_id_number = '9' AND lane_id_number = '2' THEN 3
		ELSE 0
	END AS RouteSequence
FROM WCG_STAGE.itis.camera_site c
LEFT JOIN WCG_Stage.itis.operational_area o ON c.operational_area_id = o.id
LEFT JOIN WCG_Stage.itis.traffic_centre t ON c.traffic_centre_id = t.id
































