
CREATE FUNCTION [Chronological].[DateIsInNextMonth] (
	@date DATE
)
RETURNS BIT AS
BEGIN
	DECLARE @nextMonth INT = MONTH(DATEADD(MONTH, 1, GETDATE()))
	DECLARE @nextMonthYear INT = YEAR(DATEADD(MONTH, 1, GETDATE()))

	RETURN CASE
		WHEN MONTH(@date) = @nextMonth AND YEAR(@date) = @nextMonthYear THEN 1
		ELSE 0 
	END
END