



CREATE VIEW [dbo].[LoadFactEBATEventDuration] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-10-2017
-- Reason				:	Load View for FactEBATEventDuration
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	15-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.TimeKey,-1)				AS EventTimeKey
	,ISNULL(d2.DateKey,-1)				AS EventDateKey
    ,ISNULL(d3.EBATDeviceKey,-1)		AS EBATDeviceKey
    ,ISNULL(d4.MagistratesCourtKey,-1)	AS MagistratesCourtKey
    ,ISNULL(d5.EbatEventKey,-1)			AS EBATEventKey
	,ISNULL(d6.EBATIncidentKey,-1)		AS EBATIncidentKey
	,ISNULL(d7.EBATRoleKey,-1)			AS EBATRoleKey
	,ISNULL(d8.EBATRolePlayerKey,-1)	AS EBATRolePlayerKey
	,ISNULL(d9.OperatorKey,-1)			AS OperatorKey
	,ISNULL(d10.OfficerKey,-1)			AS OfficerKey
	,ISNULL(d11.DateKey,-1)				AS OperationsDateKey
	,tfm.UniqueId						AS UniqueId
	,tfm.EBATEventID					AS EventID
	,tfm.EventDuration					AS EventDuration
	,tfm.DeltaLogKey					AS DeltaLogKey			
FROM WCG_Stage.ebat.transformFactEBATEventDuration as tfm	
LEFT OUTER JOIN WCG_DW.dbo.DimTime				d1 ON tfm.EventTime = d1.FullTime
LEFT OUTER JOIN WCG_DW.dbo.DimDate				d2 ON tfm.EventDate = d2.FullDate
LEFT OUTER JOIN WCG_DW.dbo.DimEBATDevice		d3 ON tfm.EBATDeviceID = d3.EBATDeviceID
LEFT OUTER JOIN WCG_DW.dbo.DimMagistratesCourt	d4 ON tfm.MagistratesCourtID = d4.MagistratesCourtID
LEFT OUTER JOIN WCG_DW.dbo.DimEBATEvent			d5 ON tfm.EBATEventID = d5.EBATEventID
LEFT OUTER JOIN WCG_DW.dbo.DimEBATIncident		d6 ON tfm.UniqueId = d6.EBATReportId
LEFT OUTER JOIN WCG_DW.dbo.DimEBATRole			d7 ON tfm.EBATRole = d7.ebatRole
LEFT OUTER JOIN WCG_DW.dbo.DimEBATRolePlayer	d8 ON tfm.EBATRolePlayerID = d8.EBATRolePlayerID
LEFT OUTER JOIN WCG_DW.dbo.DimOperator			d9 ON tfm.OperatorID = d9.OperatorId
LEFT OUTER JOIN WCG_DW.dbo.DimOfficer			d10 ON tfm.OfficerID = d10.OfficerId
LEFT OUTER JOIN WCG_DW.dbo.DimDate				d11 ON tfm.OperationsDate = d11.FullDate













