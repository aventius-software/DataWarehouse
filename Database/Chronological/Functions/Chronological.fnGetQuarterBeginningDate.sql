CREATE FUNCTION [Chronological].[fnGetQuarterBeginningDate] (
	@date DATE
)
RETURNS DATE AS
BEGIN
	-- Calculates the beginning date for the quarter that the specified date is in
	RETURN DATEADD(QUARTER, DATEPART(QUARTER, @date) - 1, DATEFROMPARTS(YEAR(@date), 1, 1))
END