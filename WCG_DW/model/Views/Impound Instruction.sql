
CREATE VIEW [model].[Impound Instruction] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   16 Feb 2019 2:54:36 PM
-- Reason               :   Semantic View for dbo.DimImpoundInstruction
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ImpoundInstructionKey] AS [ImpoundInstructionKey]
	,[CreateDate] AS [Create Date]
	,[HasJack] AS [Has Jack]
	,[HasSpanners] AS [Has Spanners]
	,[HasWheelBrace] AS [Has Wheel Brace]
	,[ImpoundDate] AS [Impound Date]
	,[ImpoundInstructionID] AS [Impound Instruction ID]
	,[ImpoundOfficer] AS [Impound Officer]
	,[ImpoundStatus] AS [Impound Status]
	,[IncomingImpoundOfficerSignatureDate] AS [Incoming Impound Officer Signature Date]
	,[IncomingVehicleOwnerSignatureDate] AS [Incoming Vehicle Owner Signature Date]
	,[IsReleasedAsScrap] AS [Is Released As Scrap]
	,[Location] AS [Location]
	,[OffenceCount] AS [Offence Count]
	,[OffenceDate] AS [Offence Date]
	,[OffenceFine] AS [Offence Fine]
	,[OfficerComments] AS [Officer Comments]
	,[OutgoingImpoundOfficerSignatureDate] AS [Outgoing Impound Officer Signature Date]
	,[OutgoingVehicleOwnerSignatureDate] AS [Outgoing Vehicle Owner Signature Date]
	,[OverrideReason] AS [Override Reason]
	,[PoundFacility] AS [Pound Facility]
	,[ReleaseDate] AS [Release Date]
	,[ScrapReason] AS [Scrap Reason]
	,[TrafficOfficer] AS [Traffic Officer]
	,[ViolationType] AS [Violation Type]
	,[WrittenNoticeNumber] AS [Written Notice Number]
FROM WCG_DW.dbo.DimImpoundInstruction WITH (NOLOCK)
