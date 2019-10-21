

CREATE VIEW [cle].[transformDimVehicle] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-02-2018
-- Reason				:	Transform view for Vehicle
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------


WITH CTE AS (
SELECT 
	 CAST(ISNULL(MainColour,'Unknown') AS VARCHAR(50))			AS Colour
	,CAST(ISNULL(MainColourCode,'UNK') AS VARCHAR(10))			AS ColourCode
	,CAST(ISNULL(Make,'Unknown') AS VARCHAR(50))				AS Make
	,CAST(ISNULL(MakeCode,'UNK') AS VARCHAR(10))				AS MakeCode
	,CAST(ISNULL(ModelName,'Unknown') AS VARCHAR(50))			AS Model
	,CAST(ISNULL(ModelNameCode,'UNK') AS VARCHAR(10))			AS ModelCode
	,CAST(LicenceNumber AS VARCHAR(20))							AS RegistrationNo 
	,CAST(ISNULL(Category,'Not on eNatis') AS VARCHAR(50))		AS VehicleCategory
	,CAST(ISNULL(CategoryCode,'UNK') AS VARCHAR(10))			AS VehicleCategoryCode
	,CAST(ISNULL(VehicleUsage,'Not on eNatis') AS VARCHAR(50))	AS VehicleUsage
	,CAST(ISNULL(VehicleUsageCode,'UNK') AS VARCHAR(10))		AS VehicleUsageCode
	,ROW_NUMBER() OVER 
		(PARTITION BY LicenceNumber, DeltaLogKey 
		 ORDER BY StorageTimeStamp)								AS RowNumber
	,Deltalogkey												AS DeltaLogKey
FROM WCG_Stage.cle.VehicleEnquiryResponses
WHERE LicenceNumber IS NOT NULL
)

SELECT 
	 Colour
	,ColourCode
	,Make
	,MakeCode
	,Model
	,ModelCode
	,RegistrationNo 
	,VehicleCategory
	,VehicleCategoryCode
	,VehicleUsage
	,VehicleUsageCode
	,RowNumber
	,DeltaLogKey
FROM CTE
WHERE RowNumber = 1
