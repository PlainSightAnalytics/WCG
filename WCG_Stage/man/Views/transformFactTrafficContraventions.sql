


CREATE VIEW [man].[transformFactTrafficContraventions]

AS
--------------------------------------------------------------------------------------------------------------------------------------
-- Author			:	Trevor Howe
-- Date Created		:	2019-06-15
-- Reason			:	Transform View for FactTrafficContraventions
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By		:
-- Modified On		:
-- Reason			:
--------------------------------------------------------------------------------------------------------------------------------------


SELECT
	 CASE
		WHEN CaseResultDate = '' THEN NULL
		ELSE 
			DATEFROMPARTS(
				 SUBSTRING(CaseResultDate,7,4)
				,SUBSTRING(CaseResultDate,4,2)
				,SUBSTRING(CaseResultDate,1,2)
			)
		END														AS [CaseResultDate]
	,CAST(Charge1 AS VARCHAR(10))								AS [ChargeCode]
	,CASE
		WHEN CourtDate = '' THEN NULL
		ELSE 
			DATEFROMPARTS(
					SUBSTRING(CourtDate,7,4)
				,SUBSTRING(CourtDate,4,2)
				,SUBSTRING(CourtDate,1,2)
			)
		END														AS [CourtDate]
	,CAST(CurrFine AS NUMERIC(11,2))							AS [CurrentAmount]
	,CAST(NULLIF(ID_NO,'0') AS VARCHAR(30))						AS [IDDocumentNumber]
	,CASE
		WHEN IssueDate = '' THEN NULL
		ELSE 
			DATEFROMPARTS(
				 SUBSTRING(IssueDate,7,4)
				,SUBSTRING(IssueDate,4,2)
				,SUBSTRING(IssueDate,1,2)
			)	
		END														AS [IssueDate]
	,CAST(LastAction AS VARCHAR(50))							AS [LastAction]
	,CAST(LastActionDate AS DATE)								AS [LastActionDate]
	,CAST(
		CASE
			WHEN NULLIF(m.Magistrates_Court_GUID,'') IS NULL THEN NULL
			ELSE m.Magistrates_Court_GUID 
		END AS UNIQUEIDENTIFIER)								AS [MagistratesCourtGUID]
	,CAST(NoticeNumber AS VARCHAR(50))							AS [NoticeNumber]
	,CAST(Stage	AS VARCHAR(30))									AS [NoticeStage]
	,CAST(Status AS VARCHAR(30))								AS [NoticeStatus]
	,CAST(NoticeType AS VARCHAR(30))							AS [NoticeType]
	,CASE
		WHEN OffenceDate = '' THEN NULL
		ELSE 
			DATEFROMPARTS(
				 SUBSTRING(OffenceDate,7,4)
				,SUBSTRING(OffenceDate,4,2)
				,SUBSTRING(OffenceDate,1,2)
			)
		END														AS [OffenceDate]
	,CAST(OrigFine AS NUMERIC(11,2))							AS [OriginalAmount]
	,CAST(PaidFine AS NUMERIC(11,2))							AS [PaidAmount]
	,CASE
		WHEN PaymentDueDate = '' THEN NULL
		WHEN SUBSTRING(PaymentDueDate,7,4) IN ('2-03','9-10','9-17') THEN NULL
		ELSE
			DATEFROMPARTS(
				 SUBSTRING(PaymentDueDate,7,4)
				,SUBSTRING(PaymentDueDate,4,2)
				,SUBSTRING(PaymentDueDate,1,2)
			)
		END														AS [PaymentDueDate]
	,CASE
		WHEN Payment_Rec_Date = '' THEN NULL
		ELSE 
			DATEFROMPARTS(
				 SUBSTRING(Payment_Rec_Date,7,4)
				,SUBSTRING(Payment_Rec_Date,4,2)
				,SUBSTRING(Payment_Rec_Date,1,2)
			 )
		END														AS [PaymentReceiptDate]
	,CAST(ReceiptNumber AS VARCHAR(50))							AS [ReceiptNumber]
	,CAST(redcAmt AS NUMERIC(11,2))								AS [ReducedAmount]
	,CAST(Regno AS VARCHAR(20))									AS [RegistrationNo]
	,CAST(
		CASE
			WHEN NULLIF(m.Traffic_Centre_GUID,'') IS NULL THEN NULL
			ELSE m.Traffic_Centre_GUID 
		END AS UNIQUEIDENTIFIER)								AS [TrafficCentreGUID]
	,CAST(UneqPaid AS NUMERIC(11,2))							AS [UnequalPaidAmount]
	,CASE
		WHEN WarrantDate = '' THEN NULL
		ELSE 
			DATEFROMPARTS(
				 SUBSTRING(WarrantDate,7,4)
				,SUBSTRING(WarrantDate,4,2)
				,SUBSTRING(WarrantDate,1,2)
			 )	
		END														AS [WarrantDate]
	,CAST(WDAmt AS NUMERIC(11,2))								AS [WithdrawnAmount]
FROM man.WCGNotice n WITH (NOLOCK)
LEFT JOIN man.[Magistrates Court Traffic Centre Mapping] m ON n.CourtCode = m.CourtCode
