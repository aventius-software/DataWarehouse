
CREATE FUNCTION [Chronological].[CalendarMonthStartDate] (
	@date DATE
)
RETURNS DATE AS
BEGIN
	RETURN DATEFROMPARTS(YEAR(@date), MONTH(@date), 1)
END