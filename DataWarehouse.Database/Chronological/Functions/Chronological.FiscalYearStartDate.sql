CREATE FUNCTION [Chronological].[FiscalYearStartDate] (
	@date DATE
	,@fiscalYearStartMonth TINYINT = 4
)
RETURNS DATE AS
BEGIN
	-- return invalid value to trigger error if the start month is not valid
	IF NOT @fiscalYearStartMonth BETWEEN 1 AND 12 RETURN '1'

	-- otherwise just adjust the year as appropriate
	DECLARE @year SMALLINT = CASE
		WHEN MONTH(@date) < @fiscalYearStartMonth THEN YEAR(@date) - 1 
		ELSE YEAR(@date)
	END

	-- and create a date from the parts ;-)
	RETURN DATEFROMPARTS(@year, @fiscalYearStartMonth, 1)	
END