



CREATE VIEW [itis].[transformDimUser] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-06-2016
-- Reason				:	Transform view for User
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 [id]										AS [UserID]
	,[display]									AS [User]
	,ISNULL([infrastructure_number],'Unknown')  AS [InfrastructureNumber]
	,ISNULL([traffic_centre_string],'Unknown')  AS [UserTrafficCentre]
	,ISNULL([designation],'Unknown')			AS [Designation]
	,ISNULL([role_display],'Unknown')			AS [Role]
	,DeltaLogKey								AS [DeltaLogKey]
FROM [WCG_Stage].[itis].[user]










