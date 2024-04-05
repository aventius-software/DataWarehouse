
CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForBoxingDay] (
	@year INT
)
RETURNS DATE AS
BEGIN
	-- This code is valid for use in the UK, other countries may need adjustments!
	-- Christmas and Boxing day are of course 25th/26th December. For more info on 
	-- UK bank holidays see this link below
	-- https://www.gov.uk/bank-holidays?mod=article_inline

	-- First get the real Boxing day for the year
	DECLARE @boxingDay DATE = DATEFROMPARTS(@year, 12, 26)
		
	-- We need to adjust if this date is on the weekend...
	RETURN CASE
		-- If Boxing day is on a Saturday (and Boxing day the Sunday), then we jump 2 days
		-- to get the Monday bank holiday. If Boxing day is on a Sunday though, this means 
		-- that Christmas day was on the Saturday, which means we allocate the Monday for 
		-- the Christmas bank holiday and the Tuesday for the Boxing day bank holiday. So 
		-- either way we still just need to skip 2 days to find our bank holiday
		WHEN DATENAME(WEEKDAY, @boxingDay) IN ('Saturday', 'Sunday') THEN DATEADD(DAY, 2, @boxingDay)
		
		-- Otherwise no adjustment needed ;-)
		ELSE @boxingDay
	END		
END