CREATE FUNCTION [Chronological].[IsValidDate] (
	@year INT
	,@month INT
	,@day INT
)
RETURNS BIT AS
BEGIN
	-- this function checks for a specific year, month and day to see
	-- if its a valid date

	-- first get the year as a varchar
	DECLARE @yearStr VARCHAR(4) = CAST(@year AS VARCHAR(4))

	-- generate a 2 character leading zero month
	DECLARE @monthStr VARCHAR(2) = CASE
		WHEN @month < 10 THEN '0' + CAST(@month AS VARCHAR(1))
		ELSE CAST(@month AS VARCHAR(2))
	END

	-- generate a 2 character leading zero day
	DECLARE @dayStr VARCHAR(2) = CASE
		WHEN @day < 10 THEN '0' + CAST(@day AS VARCHAR(1))
		ELSE CAST(@day AS VARCHAR(2))
	END

	-- now we can use the standard ISDATE() function
	-- note we are using the YYYYMMDD format of the ISO 8601 
	-- standard here as this should prevent problems with 
	-- dates being interpreted differently depending on the
	-- culture or language settings
	RETURN ISDATE(@yearStr + @monthStr + @dayStr)
END