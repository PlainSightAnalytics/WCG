


CREATE VIEW [cle].[transformDimVehicleType] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	18-02-2018
-- Reason				:	Transform view for VehicleType
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------


WITH CTE AS (
SELECT 
	 CAST(ISNULL(Category,'Unknown') AS VARCHAR(50))		AS VehicleCategory
	,CAST(ISNULL(CategoryCode,'0') AS VARCHAR(10))			AS VehicleCategoryCode
	,CAST(ISNULL(VehicleUsage,'Unknown') AS VARCHAR(50))	AS VehicleUsage
	,CAST(ISNULL(VehicleUsageCode,'00') AS VARCHAR(10))		AS VehicleUsageCode
	,ROW_NUMBER() OVER 
		(PARTITION BY ISNULL(CategoryCode,'0'), ISNULL(VehicleUsageCode,'00'), DeltaLogKey 
		 ORDER BY StorageTimeStamp)								AS RowNumber
	,Deltalogkey												AS DeltaLogKey
FROM WCG_Stage.cle.VehicleEnquiryResponses
WHERE LicenceNumber IS NOT NULL
)

SELECT 
	 VehicleCategory
	,VehicleCategoryCode
	,VehicleUsage
	,VehicleUsageCode
	,RowNumber
	,DeltaLogKey
FROM CTE
WHERE RowNumber = 1

