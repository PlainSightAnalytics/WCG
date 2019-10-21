
CREATE VIEW [model].[Traffic Centre] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimTrafficCentre
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [TrafficCentreKey] AS [TrafficCentreKey]
	,[Authority] AS [Authority]
	,[District] AS [District]
	,[EmailAddress] AS [Email Address]
	,[MagistratesCourt] AS [Magistrates Court]
	,[MagistratesCourtCode] AS [Magistrates Court Code]
	,[MagistratesCourtNumber] AS [Magistrates Court Number]
	,[Municipality] AS [Municipality]
	,[MunicipalityHasElectronicPayment] AS [Municipality Has Electronic Payment]
	,[MunicipalityHasPostalPayment] AS [Municipality Has Postal Payment]
	,[MunicipalityPlaceOfPayment] AS [Municipality Place Of Payment]
	,[Province] AS [Province]
	,[RegionalArea] AS [Regional Area]
	,[RegionalDirector] AS [Regional Director]
	,[TCC] AS [TCC]
	,[TelephoneNo] AS [Telephone No]
	,[TrafficCentre] AS [Traffic Centre]
	,[TrafficCentreCode] AS [Traffic Centre Code]
	,[TrafficCentreID] AS [Traffic Centre ID]
FROM WCG_DW.dbo.DimTrafficCentre WITH (NOLOCK)
