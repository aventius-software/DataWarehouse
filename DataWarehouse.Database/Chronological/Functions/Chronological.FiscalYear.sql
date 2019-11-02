CREATE FUNCTION [Chronological].[FiscalYear] (
	@date DATE
	,@separator VARCHAR(1)
)
RETURNS VARCHAR(7)
AS
BEGIN
	-- first calculate the starting year, if the month is 
	-- is before April then the starting year is the previous year
	-- otherwise its just the current year
	DECLARE @startingFiscalYear INT = CASE 
		WHEN MONTH(@date) < 4 THEN YEAR(@date) - 1
		ELSE YEAR(@date)
	END	

	-- return our fiscal year, note that we just add 1 to 
	-- the starting year to get the ending year
	RETURN CAST(@startingFiscalYear AS VARCHAR(4)) + @separator + RIGHT(CAST(1 + @startingFiscalYear AS VARCHAR(4)), 2)
END