CREATE FUNCTION DatabaseAdministration.[fnGetForeignKeysForTable] (	
	@schemaName VARCHAR(128)
	,@tableName VARCHAR(128)
)
RETURNS @table TABLE (
	[ForeignKeyConstraintName] VARCHAR(128) NOT NULL
	,[ReferencedTableName] VARCHAR(128) NOT NULL
	,[ReferencedSchemaName] VARCHAR(128) NOT NULL
	,[ReferencedColumnName] VARCHAR(128) NOT NULL
	,[ColumnName] VARCHAR(128) NOT NULL
)
AS
BEGIN
	-- Get list of tables and save	
	INSERT INTO
    @table (
		[ForeignKeyConstraintName]
		,[ReferencedTableName]
		,[ReferencedSchemaName]
		,[ReferencedColumnName]
		,[ColumnName]
    )
    
	SELECT    
	[ForeignKeyConstraintName] = OBJECT_NAME([constraint_object_id])
	,[ReferencedTableName] = OBJECT_NAME([referenced_object_id])
	,[ReferencedSchemaName] = OBJECT_SCHEMA_NAME([referenced_object_id])
	,[ReferencedColumnName] = COL_NAME([referenced_object_id], [referenced_column_id])
	,[ColumnName] = COL_NAME([parent_object_id], [parent_column_id])

	FROM 
	sys.foreign_key_columns

	WHERE
	OBJECT_SCHEMA_NAME([parent_object_id]) = @schemaName
	AND OBJECT_NAME([parent_object_id]) = @tableName

	-- Done
	RETURN
END