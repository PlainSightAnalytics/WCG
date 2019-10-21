
CREATE PROCEDURE [dbo].[prcLoadDimTime]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	
-- Date Created			:	
-- Reason				:	Populates DimTime 
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	exec dbo.prcLoadDimTime -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT

AS

DECLARE @Hour AS INT = 0
DECLARE @HourShort AS INT = 0
DECLARE @Minute AS INT = 0

CREATE TABLE #ConformDimTime (
	[TimeKey] INT,
	[FullTime] TIME,
	[TimeName] VARCHAR(10),
	[AMPMIndicator] VARCHAR(2),
	[Hour12] INT,
	[Hour24] INT,
	[MinuteOfHour] INT,
	[HourBand] VARCHAR(15),
	[PeriodOfDay] VARCHAR(10),
	[QuarterHourBand] VARCHAR(10),
	[HalfHourBand] VARCHAR(10),
    [Shift] VARCHAR(10),
    [HourShiftSort] INT,
    [Is6amTo8pm] VARCHAR(3)

)
WHILE @Hour < 24
BEGIN
	
	IF @Hour > 12
		SELECT @HourShort = @Hour - 12
	ELSE
		SELECT @HourShort = @Hour
		
	WHILE @Minute < 60
	BEGIN

	INSERT INTO #ConformDimTime (TimeKey, FullTime, TimeName, AMPMIndicator, Hour12, Hour24, MinuteOfHour, Is6amTo8pm, HourBand, PeriodOfDay, QuarterHourBand, HalfHourBand)
	VALUES(
		(@Hour * 100) + @Minute
		,TIMEFROMPARTS(@Hour, @Minute, 0, 0, 0)
		,CAST(TIMEFROMPARTS(CASE WHEN @Hour = 0 THEN 12 ElSE @Hour END, @Minute, 0, 0, 0) AS VARCHAR(5))
		+ CASE
			WHEN @Hour < 12 THEN ' AM'
			ELSE ' PM'
		END
		,CASE
			WHEN @Hour < 12 THEN 'AM'
			ELSE 'PM'
		END
		,CASE
			WHEN @Hour < 13 THEN @Hour
			ELSE @HourShort
		END
		,@Hour
		,@Minute
		,CAST(CASE
			WHEN @Hour BETWEEN 6 and 19 THEN 'Yes'
			WHEN @Hour = 20 AND @Minute = 0 THEN 'Yes'
			ELSE 'No'
		END AS VARCHAR(10))
		,CAST(CAST(
			CASE
				WHEN @HourShort = 0 THEN 12
				ELSE @HourShort
			END AS VARCHAR(2)) + 
		 CASE
			WHEN @Hour < 12 THEN ' AM'
			ELSE ' PM'
		 END +
		' to ' + 
		CAST(
			CASE 
				WHEN @HourShort = 11 THEN 12
				ELSE (@HourShort + 1) 
			END AS VARCHAR(2)) +
		CASE
			WHEN @Hour + 1 < 12 THEN ' AM'
			WHEN @Hour + 1 = 24 THEN ' AM'
			ELSE ' PM'
		 END AS VARCHAR(15))
		 ,CAST(
		CASE
			WHEN (@Hour * 100) + @Minute BETWEEN 0 AND 559 THEN 'Night'
			WHEN (@Hour * 100) + @Minute BETWEEN 600 AND 1159 THEN 'Morning'
			WHEN (@Hour * 100) + @Minute BETWEEN 1200 AND 1759 THEN 'Afternoon'
			WHEN (@Hour * 100) + @Minute BETWEEN 1800 AND 2359 THEN 'Night'
		END AS VARCHAR(10))
		,CAST(
			CASE
				WHEN @Minute BETWEEN 0 and 14 
				THEN 
					CAST(CASE WHEN @Hour = 0 THEN 12 ELSE @HourShort END AS VARCHAR(2)) + 
					':00' +  
					CASE
						WHEN @Hour < 12 THEN ' AM'
						ELSE ' PM'
					END
				WHEN @Minute BETWEEN 15 and 29 THEN 
					CAST(CASE WHEN @Hour = 0 THEN 12 ELSE @HourShort END AS VARCHAR(2)) + 
					':15' +  
					CASE
						WHEN @Hour < 12 THEN ' AM'
						ELSE ' PM'
					END
				WHEN @Minute BETWEEN 30 and 44 THEN 
					CAST(CASE WHEN @Hour = 0 THEN 12 ELSE @HourShort END AS VARCHAR(2)) + 
					':30' +  
					CASE
						WHEN @Hour < 12 THEN ' AM'
						ELSE ' PM'
					END
				WHEN @Minute BETWEEN 45 and 59 THEN 
					CAST(CASE WHEN @Hour = 0 THEN 12 ELSE @HourShort END AS VARCHAR(2)) + 
					':45' +  
					CASE
						WHEN @Hour < 12 THEN ' AM'
						ELSE ' PM'
					END
			END AS VARCHAR(10))
		,CAST(
			CASE
				WHEN @Minute BETWEEN 0 and 29 
				THEN 
					CAST(CASE WHEN @Hour = 0 THEN 12 ELSE @HourShort END AS VARCHAR(2)) + 
					':00' +  
					CASE
						WHEN @Hour < 12 THEN ' AM'
						ELSE ' PM'
					END
				WHEN @Minute BETWEEN 30 and 59 THEN 
					CAST(CASE WHEN @Hour = 0 THEN 12 ELSE @HourShort END AS VARCHAR(2)) + 
					':30' +  
					CASE
						WHEN @Hour < 12 THEN ' AM'
						ELSE ' PM'
					END
				END AS VARCHAR(10))
			
	)

	SET @Minute = @Minute + 1

	END

	SET @Hour = @Hour + 1
	SET @Minute = 0

END


/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimTime dim
USING #ConformDimTime conf
ON (dim.FullTime = conf.FullTime)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (TimeKey, AMPMIndicator, FullTime, HalfHourBand, Hour12, Hour24, HourBand, MinuteOfHour, Is6amTo8pm, PeriodOfDay, QuarterHourBand, TimeName, InsertAuditKey, UpdateAuditKey)
	VALUES (
		conf.TimeKey, conf.AMPMIndicator, conf.FullTime, conf.HalfHourBand, conf.Hour12, conf.Hour24, conf.HourBand, conf.MinuteOfHour, conf.Is6amTo8pm, 
		conf.PeriodOfDay, conf.QuarterHourBand, conf.TimeName, @AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (dim.AMPMIndicator <> conf.AMPMIndicator
	  OR dim.HalfHourBand <> conf.HalfHourBand
      OR dim.Hour12 <> conf.Hour12
      OR dim.Hour24 <> conf.Hour24
      OR dim.HourBand <> conf.HourBand
      OR dim.MinuteOfHour <> conf.MinuteOfHour
      OR dim.Is6amTo8pm <> conf.Is6amTo8pm
      OR dim.PeriodOfDay <> conf.PeriodOfDay
	  OR dim.QuarterHourBand <> conf.QuarterHourBand
      OR dim.TimeName <> conf.TimeName
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.AMPMIndicator = conf.AMPMIndicator,
			dim.HalfHourBand = conf.HalfHourBand,
			dim.Hour12 = conf.Hour12,
			dim.Hour24 = conf.Hour24,
			dim.HourBand = conf.HourBand,
			dim.MinuteOfHour = conf.MinuteOfHour,
			dim.Is6amTo8pm = conf.Is6amTo8pm,
			dim.PeriodOfDay = conf.PeriodOfDay,
			dim.QuarterHourBand = conf.QuarterHourBand,
			dim.TimeName = conf.TimeName,
			/* Update System Fields */
			dim.UpdateAuditKey = @AuditKey,
			dim.RowIsInferred = 'N',
			dim.RowChangeReason = 'SCD Type 1 Change';

DROP TABLE #ConformDimTime




;
;
;
;