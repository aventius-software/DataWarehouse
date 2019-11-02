
CREATE FUNCTION [Chronological].[PreviousFiscalMonth] (
	@date DATE	
)
RETURNS TINYINT
AS
BEGIN
	RETURN MONTH(DATEADD(MONTH, -4, @date))
END