require 'pg'

require_relative "../config"

class PgsqlRoom

  def initialize
    @conn = PG.connect(
        :dbname   => PGSQL_DB_NAME,
        :host     => PGSQL_DB_IP,
        :port     => PGSQL_DB_PORT,
        :user     => PGSQL_USERNAME,
        :password => PGSQL_PASSWORD,
    )
  end

  def get_rooms
    sqlResult = Array.new

    sql = "SELECT room_id,level FROM rooms;"
    @conn.exec(sql) do |result|
      result.each do |row|
        room_id = "%s" % row.values_at('room_id')
        level = "%d" % row.values_at('level')

        room_object = Hash.new
        room_object["room_id"] = room_id
        room_object["level"] = level

        sqlResult << room_object
      end
    end
    return sqlResult
  end

  def get_desks
    sqlResult = Array.new

    sql = "SELECT desk_id,room_id FROM desks;"
    @conn.exec(sql) do |result|
      result.each do |row|
        desk_id = "%s" % row.values_at('desk_id')
        room_id = "%s" % row.values_at('room_id')

        desk_object = Hash.new
        desk_object["desk_id"] = desk_id
        desk_object["room_id"] = room_id

        sqlResult << desk_object
      end
    end
    return sqlResult
  end
end