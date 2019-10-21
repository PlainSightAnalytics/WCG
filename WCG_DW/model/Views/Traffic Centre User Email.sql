CREATE VIEW [model].[Traffic Centre User Email] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-08-2016
-- Reason				:	Model view for Traffic Centre User Security
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	TrafficCentreKey AS TrafficCentreKey, 
	LTRIM(VALUE) AS [User Email Address]
FROM WCG_DW.dbo.DimTrafficCentre WITH (NOLOCK)
    CROSS APPLY STRING_SPLIT(SecurityEmailList, ';')