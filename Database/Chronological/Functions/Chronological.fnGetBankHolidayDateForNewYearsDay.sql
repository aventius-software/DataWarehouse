CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForNewYearsDay] (
	@year INT
)
RETURNS DATE AS
BEGIN
	-- Calculates the bank holiday for new years day on the specified year. See
	-- the link below for UK Government details on bank holidays. Other countries
	-- may have different calculations https://www.gov.uk/bank-holidays?mod=article_inline

	-- First get the real new years day for the specified year
	DECLARE @newYearsDay DATE = DATEFROMPARTS(@year, 1, 1)

	-- Adjust if on a weekend
	IF DATENAME(WEEKDAY, @newYearsDay) = 'Saturday' SET @newYearsDay = DATEADD(DAY, 2, @newYearsDay)
	IF DATENAME(WEEKDAY, @newYearsDay) = 'Sunday' SET @newYearsDay = DATEADD(DAY, 1, @newYearsDay)

	-- Is the specified date the bank holiday date for new year?
	RETURN @newYearsDay
END