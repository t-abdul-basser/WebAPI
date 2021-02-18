-- at first removing default value
declare @command nvarchar(1000)
select @command = 'ALTER TABLE ${ohdsiSchema}.pathway_event_cohort DROP CONSTRAINT ' + d.name
from sys.tables t
  join sys.default_constraints d on d.parent_object_id = t.object_id
  join sys.columns c on c.object_id = t.object_id and c.column_id = d.parent_column_id
where
  t.name = 'pathway_event_cohort'
  and t.schema_id = schema_id('${ohdsiSchema}')
  and c.name = 'is_deleted';
execute (@command)

IF EXISTS (SELECT 1
               FROM   INFORMATION_SCHEMA.COLUMNS
               WHERE  TABLE_NAME = 'pathway_event_cohort'
                      AND COLUMN_NAME = 'is_deleted'
                      AND TABLE_SCHEMA='${ohdsiSchema}')
  BEGIN
      ALTER TABLE pathway_event_cohort
        DROP COLUMN is_deleted
  END