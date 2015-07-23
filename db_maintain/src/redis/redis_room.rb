require 'redis'

require_relative '../tools/random_number'

class RedisRoom
  def initialize
    @conn = Redis.new(:host => Redis_DB_IP, :port => Redis_DB_PORT, :db => Redis_DB_NUMBER)
  end

  def set_roomlist(sqlResult)
    sqlResult.each do |room_object|
      room_id = room_object["room_id"]

      add_list("rooms",room_id)

      puts "rooms add item %s" % [room_id]
    end
  end

  def set_desklist(sqlResult)
    sqlResult.each do |room_object|
      desk_id = room_object["desk_id"]

      add_list("desks",desk_id)

      puts "desks add item %s" % [desk_id]
    end
  end

  def set_rooms(sqlResult)
    sqlResult.each do |room_object|
      room_id = room_object["room_id"]
      level = room_object["level"]

      map_name = "room_" + room_id

      set_map(map_name,"room_id",room_id)
      set_map(map_name,"level",level)

      puts "%s, room_id %s, level %d" % [map_name,room_id,level]
    end
  end

  def set_desks(sqlResult)
    sqlResult.each do |desk_object|
      desk_id = desk_object["desk_id"]
      room_id = desk_object["room_id"]

      map_name = "desk_" + desk_id

      set_map(map_name,"desk_id",desk_id)
      set_map(map_name,"room_id",room_id)

      puts "%s, desk_id %s, room_id %s" % [map_name,desk_id,room_id]
    end
  end

  private
  def set_map(map_name,key,value)
    @conn.hset(map_name,key,value)
  end

  # key是单独的，不能重复
  def add_zset(zset_name,item)
    score = RandomNumber.now_to_number
    @conn.zadd(zset_name, score, item)
  end

  def add_list(list_name,item)
    @conn.rpush(list_name,item)
  end

end