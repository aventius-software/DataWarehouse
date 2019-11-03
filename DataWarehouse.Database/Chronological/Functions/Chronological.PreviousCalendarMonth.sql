﻿
CREATE FUNCTION [Chronological].[PreviousCalendarMonth] (
	@date DATE
)
RETURNS TINYINT AS
BEGIN
	RETURN DATEPART(MONTH, DATEADD(MONTH, -1, @date))
END