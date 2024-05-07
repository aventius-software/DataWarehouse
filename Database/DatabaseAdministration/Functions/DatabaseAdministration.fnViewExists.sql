CREATE FUNCTION [DatabaseAdministration].[fnViewExists] (
    @schemaName VARCHAR(128)
	,@viewName VARCHAR(128)
)
RETURNS BIT
AS
BEGIN
    RETURN CASE 
		WHEN EXISTS (
			SELECT
			1

			FROM
			sys.views

			WHERE
			[schema_id] = SCHEMA_ID(@schemaName)
			AND [name] = @viewName
		)
		THEN 1
		ELSE 0
	END
END