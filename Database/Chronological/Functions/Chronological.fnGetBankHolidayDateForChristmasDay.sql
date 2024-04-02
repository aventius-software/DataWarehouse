CREATE FUNCTION [Chronological].[fnGetBankHolidayDateForChristmasDay] (
	@date DATE
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

	-- First get the real Christmas for the year that the specified date parameter occurs
	DECLARE @christmasDay DATE = DATEFROMPARTS(YEAR(@date), 12, 25)
		
	-- We need to bump to the following Monday if it falls on a weekend...	
	IF DATENAME(WEEKDAY, @christmasDay) IN ('Saturday', 'Sunday')	
	BEGIN
		-- Yes... Christmas day is on a weekend, so we adjust to move the bank holiday 
		-- to the following Monday. You do a mathematical calculation for this but here
		-- I'm being intentionally specific so you can see the logic ;-)
		SET @christmasDay = CASE
			-- If Christmas is on a Friday (and Boxing day the Saturday), then we bump 3 days
			-- to the Monday for the bank holiday ;-)
			WHEN DATENAME(WEEKDAY, @christmasDay) = 'Friday' THEN DATEADD(DAY, 3, @christmasDay)

			-- If Christmas is on a Saturday (and Boxing day the Sunday), then we bump 2 days
			-- to the Monday for the bank holiday ;-)
			WHEN DATENAME(WEEKDAY, @christmasDay) = 'Saturday' THEN DATEADD(DAY, 2, @christmasDay)

			-- Which means if we're here, then Christmas has fallen on a Sunday, so we only need 
			-- to move one day forward to get the Monday for the bank holiday
			ELSE DATEADD(DAY, 1, @christmasDay)
		END			
	END
    
	-- This should now contain the date of the bank holiday (which is not neccessarily the same
	-- date as Christmas day itself ;-)
	RETURN @christmasDay		
END