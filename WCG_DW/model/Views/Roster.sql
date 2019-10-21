

CREATE VIEW [model].[Roster] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   05 May 2018 12:19:24 PM
-- Reason               :   Semantic View for dbo.DimRoster
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [RosterKey] AS [RosterKey]
	,[IsArchived] AS [Is Archived]
	,[IsDeleted] AS [Is Deleted]
	,[IsRevised] AS [Is Revised]
	,[Roster] AS [Roster]
	,[RosterGroup] AS [Roster Group]
	,[RosterGroupDescription] AS [Roster Group Description]
	,[RosterGroupPPI] AS [Roster Group PPI]
	,[RosterGroupReportsTo] AS [Roster Group Reports To]
	,[RosterGroupSPI] AS [Roster Group SPI]
	,[RosterGUID] AS [Roster GUID]
	,[RosterStatus] AS [Roster Status]
FROM WCG_DW.dbo.DimRoster WITH (NOLOCK)

