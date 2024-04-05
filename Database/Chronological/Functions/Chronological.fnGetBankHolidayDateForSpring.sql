
CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForSpring] (
	@year INT 
)
RETURNS DATE AS
BEGIN	
	-- Spring bank holiday is the last Monday in May in the UK. Other countries
	-- may have different calculations. See the link here for UK Government listing
	-- on bank holidays https://www.gov.uk/bank-holidays?mod=article_inline

	-- Lets start with the last day in May for the specified year
	DECLARE @springBankHoliday DATE = DATEADD(DAY, -1, DATEFROMPARTS(@year, 6, 1))

	-- Do we need to adjust the date?
	RETURN CASE
		-- It is a Monday, so no adjustment needed...
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Monday' THEN @springBankHoliday

		-- It's not a Monday, so we need to keep going back to find a Monday
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Tuesday' THEN DATEADD(DAY, -1, @springBankHoliday)
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Wednesday' THEN DATEADD(DAY, -2, @springBankHoliday)
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Thursday' THEN DATEADD(DAY, -3, @springBankHoliday)
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Friday' THEN DATEADD(DAY, -4, @springBankHoliday)
		WHEN DATENAME(WEEKDAY, @springBankHoliday) = 'Saturday' THEN DATEADD(DAY, -5, @springBankHoliday)

		-- Its a Sunday so go back almost a week ;-)
		ELSE DATEADD(WEEKDAY, -6, @springBankHoliday)
	END
END