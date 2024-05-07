CREATE FUNCTION [Chronological].[fnGetDayOfTheQuarter] (
	@date DATE
)
RETURNS INT AS
BEGIN
	-- Calculates the day of the current quarter for the specified date
	RETURN DATEDIFF(DAY, [Chronological].[fnGetQuarterBeginningDate](@date), @date) + 1
END