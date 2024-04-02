CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForSpring] (
	@year INT 
)
RETURNS DATE AS
BEGIN	
	-- Spring bank holiday is the last Monday in May in the UK. Other countries
	-- may have different calculations https://www.gov.uk/bank-holidays?mod=article_inline

	-- Start with the last day in May for the specified year
	DECLARE @springBankHoliday DATE = DATEADD(DAY, -1, DATEFROMPARTS(@year, 6, 1))

	-- Adjust if not Monday...
	IF DATENAME(WEEKDAY, @springBankHoliday) <> 'Monday' SET @springBankHoliday = CASE
		-- Adjust the day
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Tuesday' THEN DATEADD(DAY, -1, @springBankHoliday)
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Wednesday' THEN DATEADD(DAY, -2, @springBankHoliday)
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Thursday' THEN DATEADD(DAY, -3, @springBankHoliday)
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Friday' THEN DATEADD(DAY, -4, @springBankHoliday)
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Saturday' THEN DATEADD(DAY, -5, @springBankHoliday)

		-- Its Sunday
		ELSE DATEADD(WEEKDAY, -6, @springBankHoliday)
	END
    
	RETURN @springBankHoliday
END