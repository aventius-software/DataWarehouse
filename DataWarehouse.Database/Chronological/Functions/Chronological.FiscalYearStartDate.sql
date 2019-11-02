CREATE FUNCTION [Chronological].[FiscalYearStartDate] (
	@date DATE
	,@fiscalStartMonth TINYINT
)
RETURNS DATE AS
BEGIN
	DECLARE @year SMALLINT = CASE
		WHEN MONTH(@date) < @fiscalStartMonth THEN YEAR(@date) - 1 
		ELSE YEAR(@date)
	END

	RETURN DATEFROMPARTS(@year, @fiscalStartMonth, 1)	
END