
CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForNewYearsDay] (
	@year INT
)
RETURNS DATE AS
BEGIN
	-- Calculates the bank holiday for new years day on the specified year. See
	-- the link below for UK Government details on bank holidays. Other countries
	-- may have different calculations https://www.gov.uk/bank-holidays?mod=article_inline

	-- First get the real new years day date for the specified year
	DECLARE @newYearsDay DATE = DATEFROMPARTS(@year, 1, 1)

	-- If it falls on a weekend we need to adjust the date for the bank holiday...
	RETURN CASE
		-- If its on Saturday, we need to skip 2 days to get the Monday for our bank holiday
		WHEN DATENAME(WEEKDAY, @newYearsDay) = 'Saturday' THEN DATEADD(DAY, 2, @newYearsDay)

		-- If its on Sunday, we just need to skip to the next day to get the Monday for our bank holiday
		WHEN DATENAME(WEEKDAY, @newYearsDay) = 'Sunday' THEN DATEADD(DAY, 1, @newYearsDay)

		-- Otherwise, its just a normal week day so no adjustment needed ;-)
		ELSE @newYearsDay
	END
END