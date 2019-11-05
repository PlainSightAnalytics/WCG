
CREATE PROCEDURE [dbo].[prcGetFlaggedVehicleAlert]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-03-2019
-- Reason				:	Load and format flagged vehicle alert as json for push to Journey
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	prcGetFlaggedVehicleAlert -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:	02-11-2019
-- Reason				:   Changed values for alert_type_id and alert_type_id_short and added new field for priority
--------------------------------------------------------------------------------------------------------------------------

@UniqueId VARCHAR(50) OUTPUT,
@JsonString VARCHAR(MAX) OUTPUT

AS


SELECT TOP 1 @UniqueId =  UniqueID
FROM WCG_DW.dbo.FactFlaggedVehicleAlerts
WHERE ISNULL(IsAlertSent,'No') = 'No'

SELECT @JsonString  = (
	SELECT
	/* Required fields */
	 'PowerBI'												AS source_system_id
	,GETUTCDATE()											AS timestamp
	,CAST(CAST(GETDATE() AS TIME) AS VARCHAR(5))			AS time_string
	,CASE FlagType
		WHEN 'Fatigue' THEN 'Fatigue'
		WHEN 'Speed' THEN 'Speed'
		WHEN 'Cloned' THEN 'Cloned Plates'
		ELSE NULL
	END														AS alert_type_id
	,CASE FlagType
		WHEN 'Fatigue' THEN 'Fatigue'
		WHEN 'Speed' THEN 'Speed'
		WHEN 'Cloned' THEN 'Cloned Plates'
		ELSE NULL
	END														AS alert_type_id_short
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
	,ISNULL(d1.RegistrationNo, d2.RegistrationNo)			AS vrm
	,GETUTCDATE()											AS primary_timestamp
	,'Open'													AS journey_status
	,'Yes'													AS processed_and_routed
	,LOWER(d3.TrafficCentreID)								AS traffic_centre_id 
	,LOWER(d4.OperationalAreaGUID )							AS operational_area_id
	,CASE
		WHEN FlagType IN ('Fatigue','Speed') 
		THEN
			CONCAT(
				'Likelihood of Duration Fatigue: Vehicle '
				,ISNULL(d1.RegistrationNo, d2.RegistrationNo)
				,' has travelled from '
				,d2.FromToCamera
				,', a distance of '
				,d2.TotalDistance
				,' kilometres in a period of '
				,d2.TripDuration 
				,' minutes at an average speed of '
				, CEILING(d2.AverageSpeed)
				,' km/h that indicates the driver has not rested sufficiently and may be fatigued, thus risking the lives of the passengers. You may stop this vehicle and force a rest period.'
				)
		WHEN FlagType IN ('Cloned') AND CHARINDEX(' to ', d2.PreviousToCurrentCamera) > 0
		THEN 
			CONCAT(
				'Likelihood of Cloned Plates: Vehicle '
				,ISNULL(d1.RegistrationNo, d2.RegistrationNo)
				,' was sighted by the camera at '
				,SUBSTRING(d2.PreviousToCurrentCamera,1,CHARINDEX(' to ',d2.PreviousToCurrentCamera)-1)
				,' and the camera at '
				,SUBSTRING(d2.PreviousToCurrentCamera,CHARINDEX(' to ',d2.PreviousToCurrentCamera) + 4,50)
				,', within '
				,d2.PreviousToCurrentActualDuration
				,' minutes of each other, implying a speed of '
				,CEILING(d2.PreviousToCurrentImpliedSpeed)
				,' which is highly unlikely, thus indicating the possibility of one of the vehicles having Cloned Plates. You may stop this vehicle and check its engine and chassis numbers against its license disc.'
			)
		ELSE 
			CONCAT(
			'Flagged Vehicle - ',
			FlagType,	
			' Alert - ',
			ISNULL(d1.RegistrationNo, d2.RegistrationNo))
		END													AS comments_notes
	,'3'													AS [priority]

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
WHERE UniqueId = @UniqueId
FOR JSON PATH)
