-- Hotfix for schema drift between deployed database and current mappers.
-- Run against the production database before verifying hall/team/audit flows.

SET @column_exists := (
    SELECT COUNT(1)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = 'competition'
      AND COLUMN_NAME = 'team_max_members'
);

SET @ddl := IF(
    @column_exists = 0,
    'ALTER TABLE competition ADD COLUMN team_max_members INT DEFAULT NULL COMMENT ''team max members'' AFTER max_participants',
    'SELECT ''competition.team_max_members already exists'' AS message'
);

PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
