require_relative "./pgsql/pgsql_init"
require_relative "./redis/redis_init"

def init_doudizhu_table
  pgsql = PgsqlInit.new
  pgsql.create_admins_table
  pgsql.create_app_versions_table
  pgsql.create_users_table
  pgsql.create_desks_table
  pgsql.create_rooms_table
end

def drop_doudizhu_table
  pgsql = PgsqlInit.new
  pgsql.drop_admins_table
  pgsql.drop_app_versions_table
  pgsql.drop_users_table
  pgsql.drop_desks_table
  pgsql.drop_rooms_table
end

def flush_redis_db
  redis = RedisInit.new
  redis.flush_db
end

def force_init_doudizhu_table
  drop_doudizhu_table
  init_doudizhu_table
end