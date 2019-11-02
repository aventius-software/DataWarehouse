
CREATE FUNCTION [Chronological].[CalendarDayOfTheYearWithSuffix] (
	@date DATE
)
RETURNS VARCHAR(5) AS
BEGIN
	DECLARE @dayOfTheYear VARCHAR(3) = CAST(DATEPART(DAYOFYEAR, @date) AS VARCHAR(3))
	
	RETURN @dayOfTheYear + CASE RIGHT(@dayOfTheYear, 1)
		WHEN 1 THEN 'st'
		WHEN 2 THEN 'nd'
		WHEN 3 THEN 'rd'
		ELSE 'th'
	END 
END