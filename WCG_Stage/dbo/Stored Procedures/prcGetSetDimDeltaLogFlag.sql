
CREATE PROCEDURE [dbo].[prcGetSetDimDeltaLogFlag]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-10-2016
-- Reason				:	Gets or Sets the Load Flag for an object on DimDeltaLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ClientName, @SchemaName, @ObjectName, @Action (0=Get,1=Set)
-- Ouputs				:
-- Test					:	exec dbo.prcUpdateDimDeltaLogFlag 6010
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@ClientName			VARCHAR(50), 
@SchemaName			VARCHAR(50), 
@ObjectName			VARCHAR(50), 
@Action				INT,
@Result				INT OUTPUT

AS

SET NOCOUNT ON

IF @Action = 0
BEGIN
	SELECT @Result = LoadFlag
	FROM WCG_DW.dbo.DimDeltaLog 
	WHERE 
		ClientName = @ClientName
		AND SchemaName = @SchemaName
		AND ObjectName = @ObjectName
END

IF @Action = 1
BEGIN
	
	UPDATE WCG_DW.dbo.DimDeltaLog 
	SET LoadFlag = 1 
	WHERE 
		ClientName = @ClientName
		AND SchemaName = @SchemaName
		AND ObjectName = @ObjectName

	SET @Result = @@ROWCOUNT
END


