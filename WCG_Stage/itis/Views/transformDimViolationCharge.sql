

CREATE VIEW [itis].[transformDimViolationCharge] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-05-2018
-- Reason				:	Transform view for ViolationCharge
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT	
	 CAST(ISNULL(c.amount,0.00) AS NUMERIC(19,2))					AS ChargeAmount
	,CAST(ISNULL(cc.name,'Unknown') AS VARCHAR(50))					AS ChargeCategory
	,CAST(ISNULL(cc.order_in_list,0) AS INT)						AS ChargeCategoryOrder
	,CAST(ISNULL(c.charge_code,'UNK') AS VARCHAR(10))				AS ChargeCode
	,CAST(ISNULL(c.charge_short_text,'Unknown') AS VARCHAR(300))	AS ChargeDescription
	,c.id															AS ChargeGUID
	,CAST(ISNULL(cs.name,'Unknown') AS VARCHAR(50))					AS ChargeSubCategory
	,CAST(ISNULL(cs.order_in_list,0) AS INT)						AS ChargeSubCategoryOrder
	,CAST(ISNULL(c.regulation_number,'') AS VARCHAR(100))			AS RegulationNumber
FROM WCG_Stage.itis.charge_code c WITH (NOLOCK)
LEFT JOIN WCG_Stage.itis.charge_code_category cc WITH (NOLOCK) ON c.charge_code_category_id = cc.id
LEFT JOIN WCG_Stage.itis.charge_code_subcategory cs WITH (NOLOCK) ON c.charge_code_subcategory_id = cs.id












