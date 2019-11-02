
CREATE FUNCTION [Chronological].[DayOfTheWeek] (
	@date DATE
	,@dateFirst TINYINT -- Standard DATEFIRST range, so Monday = 1, Sunday = 7 etc...
)
RETURNS TINYINT AS
BEGIN
	-- Since we cannot use SET DATEFIRST ??? in a function we need to account for the
	-- 'shift' in whatever the current DATEFIRST value is on the server. To do this
	-- we'll cheat and use a date that is in the past relative to the supplied date. Also
	-- to keep the return values in the same range as DATEFIRST (i.e. 1-7 instead of 0-6) 
	-- we'll need to add the @dateFirst parameter value to the date offset calculation! 
	DECLARE @dateOffset DATE = DATEADD(DAY, -1 * (@dateFirst + @@DATEFIRST), @date)

	-- now we can just use the offset'd date from above and combine with the normalisation
	-- of the DATEFIRST value itself
	DECLARE @dateFirstOffset TINYINT = (DATEPART(WEEKDAY, @dateOffset) + @@DATEFIRST) % 7
	
	-- now we can just add our offset to the DATEFIRST value and we'll get the value we want
	-- in the range of 1-7 with the value depending on which @dateFirst value was supplied!
	RETURN @dateFirstOffset + @@DATEFIRST
END