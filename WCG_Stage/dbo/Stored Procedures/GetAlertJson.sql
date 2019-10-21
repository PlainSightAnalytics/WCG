
CREATE procedure [dbo].[GetAlertJson] 

AS

SELECT 
	TOP 1
	/* Required fields */
	 'PowerBI'												AS source_system_id
	,GETUTCDATE()											AS timestamp
	,CAST(CAST(GETDATE() AS TIME) AS VARCHAR(5))			AS time_string
	,'Operating Licence'									AS alert_type_id
	,'OL'													AS alert_type_id_short
	,'PowerBI - Operating Licence'							AS alert_type
	,1														AS alert_status
	,'New'													AS alert_status_description
	,CASE FlagType
		WHEN 'Fatigue' THEN '0805W'
		WHEN 'Speed' THEN '0807W'
		WHEN 'Cloned' THEN '0808W'
		ELSE NULL
	END														AS alert_sub_type_code
	,FlagType												AS alert_sub_type
	,d1.VehicleUsage										AS vehicle_usage
	,d1.VehicleUsageCode									AS vehicle_usage_code
	,d1.Colour												AS vehicle_colour
	,d1.ColourCode											AS vehicle_colour_code
	,d1.Model												AS vehicle_model
	,d1.ModelCode											AS vehicle_model_code
	,d1.Make												AS vehicle_make
	,d1.MakeCode											AS vehicle_make_code
	,d1.VehicleCategory										AS vehicle_category
	,d1.VehicleCategoryCode									AS vehicle_category_code
	,ISNULL(d1.RegistrationNo, d2.RegistrationNo)			AS license_number
	,NULL													AS vrm
	,GETUTCDATE()											AS primary_timestamp
	,'Open'													AS journey_status
	,'Yes'													AS processed_and_routed
	,LOWER(d3.TrafficCentreID)								AS traffic_centre_id
	,LOWER(d4.OperationalAreaGUID )							AS operational_area_id
	,CONCAT(
		'Flagged Vehicle - ',
		FlagType,
		' Alert - ',
		ISNULL(d1.RegistrationNo, d2.RegistrationNo))		AS comment

	/* Not Required but we have */
	,f.SightingRecordID										AS sighting_id
	,d5.Longitude											AS longitude
	,d5.Latitude											AS latittude
	,d4.LaneID												AS lane
	,d4.TravelDirection										AS lane_direction
	,d4.SpeedSection										AS road_section
	,d4.CameraName											AS location_name_short
	,d4.CameraName											AS location_name
	,d4.SiteID												AS device_id
	,d3.TrafficCentre										AS traffic_centre_name
	
FROM WCG_DW.dbo.FactFlaggedVehicleAlerts f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimVehicle d1 ON f.VehicleKey = d1.VehicleKey
LEFT JOIN WCG_DW.dbo.DimFlaggedVehicleTrip d2 ON f.FlaggedVehicleTripKey = d2.FlaggedVehicleTripKey
LEFT JOIN WCG_DW.dbo.DimTrafficCentre d3 ON f.TrafficCentreKey = d3.TrafficCentreKey
LEFT JOIN WCG_DW.dbo.DimCamera d4 ON f.CameraKey = d4.CameraKey
LEFT JOIN WCG_DW.dbo.DimGeoLocation d5 ON f.GeoLocationKey = d5.GeoLocationKey
WHERE ISNULL(f.IsAlertSent,'No') = 'No'
FOR JSON PATH
