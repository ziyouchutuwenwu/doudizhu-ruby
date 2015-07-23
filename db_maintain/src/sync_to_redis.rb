require_relative "./pgsql/pgsql_room"
require_relative "./redis/redis_room"

def sync_to_redis
  pgsql = PgsqlRoom.new
  redis = RedisRoom.new

  roomsSqlResult = pgsql.get_rooms
  desksSqlResult = pgsql.get_desks

  redis.set_roomlist(roomsSqlResult)
  redis.set_rooms(roomsSqlResult)

  redis.set_desklist(desksSqlResult)
  redis.set_desks(desksSqlResult)
end