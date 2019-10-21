




CREATE VIEW [model].[Public Transport Traffic Control Event] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   20-04-2019
-- Reason               :   Traffic Control Event filtered for Public Transport Only
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT [TrafficControlEventKey]
      ,[Action Taken]
      ,[Alcohol Level]
      ,[Alcohol Screening]
      ,[Arrival Time]
      ,[Blood Glucose Level]
      ,[Blood Pressure Diastolic]
      ,[Blood Pressure Systolic]
      ,[Brake Taken Location]
      ,[Departure Point]
      ,[Departure Time]
      ,[Destination]
      ,[EMS Comments]
	  ,[EMS Representitive]
      ,[EMS Testing Status]
      ,[Event Completion Date Time]
      ,[Event Open Date Time]
      ,[Event Source]
      ,[Expected Duration Minutes]
      ,[Forced Close Reason]
      ,[Forced Close Type]
      ,[Has Alcohol And Drugs]
      ,[Has Disregarded Instructions]
      ,[Has Driving Violations]
      ,[Has Impound Violations]
      ,[Has Moving Violations]
      ,[Has No A G Violations]
      ,[Has Regulatory Signs]
      ,[Has Road Markings]
      ,[Has Speed Violations]
      ,[Has Violation]
      ,[Heart Rate]
      ,[Impound Offence Date Time]
      ,[Is Brake Taken]
      ,[Is Enatis Feedback Reviewed]
	  ,[Is Public Transport Survey Completed]
	  ,[Land Transport Survey Representative]
      ,[Latitude]
      ,[Location]
      ,[Longitude]
      ,[Number Of Passengers]
      ,[Number Of People Wearing Seatbelts]
      ,[Police Station]
      ,[Road Safety Comments]
      ,[Road Safety Completed Date Time]
	  ,[Road Safety Representative]
      ,[Status Code]
      ,[Traffic Control Event GUID]
      ,[Travel Direction]
	  ,[Trip Type]
  FROM [model].[Traffic Control Event] e
WHERE EXISTS (
SELECT TrafficControlEventKey FROM model.[_Public Transport Traffic Control Events] t
WHERE e.TrafficControlEventKey = t.TrafficControlEventKey)
