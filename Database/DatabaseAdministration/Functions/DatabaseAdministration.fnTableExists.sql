CREATE FUNCTION [DatabaseAdministration].[fnTableExists] (
    @schemaName VARCHAR(128)
	,@tableName VARCHAR(128)
)
RETURNS BIT
AS
BEGIN
    RETURN CASE 
		WHEN EXISTS (
			SELECT
			1

			FROM
			sys.tables

			WHERE
			[schema_id] = SCHEMA_ID(@schemaName)
			AND [name] = @tableName
		)
		THEN 1
		ELSE 0
	END
END