
CREATE FUNCTION [Chronological].[FiscalMonth] (
	@date DATE
	,@fiscalYearStartMonth TINYINT = 4
)
RETURNS TINYINT
AS
BEGIN
	-- return invalid value if the start month is not valid
	IF NOT @fiscalYearStartMonth BETWEEN 1 AND 12 RETURN -1

	-- otherwise return correct value
	RETURN MONTH(DATEADD(MONTH, -1 * (@fiscalYearStartMonth - 1), @date))
END