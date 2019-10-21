
CREATE VIEW [model].[EBAT Incident] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimEBATIncident
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [EBATIncidentKey] AS [EBATIncidentKey]
	,[AccidentIndicator] AS [Accident Indicator]
	,[AccidentLocation] AS [Accident Location]
	,[CaseNumber] AS [Case Number]
	,[EBATReportId] AS [EBAT Report Id]
	,[EBATStatus] AS [EBAT Status]
	,[NatureOfInjuries] AS [Nature Of Injuries]
	,[NotSuccessfulReason] AS [Not Successful Reason]
	,[NumberOfVehicles] AS [Number Of Vehicles]
	,[ProtocolNumber] AS [Protocol Number]
	,[ReadingResult] AS [Reading Result]
	,[ReadingResultCategory] AS [Reading Result Category]
	,[RecordNumber] AS [Record Number]
	,[ReferredIndicator] AS [Referred Indicator]
	,[ReferredLocation] AS [Referred Location]
	,[ReferredType] AS [Referred Type]
	,[RoadSideActivity] AS [Road Side Activity]
	,[SubjectDateOfBirth] AS [Subject Date Of Birth]
	,[SubjectFirstName] AS [Subject First Name]
	,[SubjectGender] AS [Subject Gender]
	,[SubjectIdentificationNumber] AS [Subject Identification Number]
	,[SubjectIdentificationType] AS [Subject Identification Type]
	,[SubjectInitials] AS [Subject Initials]
	,[SubjectOccupationSector] AS [Subject Occupation Sector]
	,[SubjectSurname] AS [Subject Surname]
	,[SubjectTelephoneNumber] AS [Subject Telephone Number]
	,[VehicleColour] AS [Vehicle Colour]
	,[VehicleMake] AS [Vehicle Make]
	,[VehicleRegistrationNumber] AS [Vehicle Registration Number]
	,[VehicleType] AS [Vehicle Type]
FROM WCG_DW.dbo.DimEBATIncident WITH (NOLOCK)
