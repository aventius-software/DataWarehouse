
CREATE FUNCTION [Chronological].[DateIsInLastMonth] (
	@date DATE
)
RETURNS BIT AS
BEGIN
	DECLARE @previousMonth INT = MONTH(DATEADD(MONTH, -1, GETDATE()))
	DECLARE @previousMonthYear INT = YEAR(DATEADD(MONTH, -1, GETDATE()))

	RETURN CASE
		WHEN MONTH(@date) = @previousMonth AND YEAR(@date) = @previousMonthYear THEN 1
		ELSE 0 
	END
END