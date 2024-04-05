
CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForChristmasDay] (
	@year INT
)
RETURNS DATE AS
BEGIN
	-- This code is valid for use in the UK, other countries may need adjustments!
	-- Christmas and Boxing day are of course 25th/26th December. However, if either of
	-- them falls on a weekend then you get a bank holiday corresponding to the one that
	-- you effectively lost as it was a weekend. In this function we're just looking at 
	-- the bank holiday we'd get for Christmas, but the calculation for Boxing day's bank 
	-- holiday is of course very similar. For more info on UK bank holidays see this link
	-- https://www.gov.uk/bank-holidays?mod=article_inline

	-- First get the real Christmas date for the year
	DECLARE @christmasDay DATE = DATEFROMPARTS(@year, 12, 25)
		
	-- We need to adjust if this date is on the weekend...
	RETURN CASE
		-- If Christmas is on a Saturday (and Boxing day the Sunday), then we jump 2 days
		-- to get to the following the Monday for the bank holiday. However, if Christmas 
		-- day is on a Sunday, this is where it gets weird as that means Boxing day (the 26th) 
		-- is on the Monday and that day is actually taken as the bank holiday for Boxing day. This 
		-- of course then means that the bank holiday for Christmas now becomes the Tuesday! Which 
		-- means either way, we still only need to jump 2 days to get the Christmas bank holiday! ;-)
		WHEN DATENAME(WEEKDAY, @christmasDay) IN ('Saturday', 'Sunday') THEN DATEADD(DAY, 2, @christmasDay)

		-- Otherwise, its just a week day, so no adjustment needed ;-)
		ELSE @christmasDay
	END		
END