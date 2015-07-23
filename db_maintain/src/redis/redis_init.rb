require 'redis'

require_relative "../config"

class RedisInit
  def initialize
    @conn = Redis.new(:host => Redis_DB_IP, :port => Redis_DB_PORT, :db => Redis_DB_NUMBER)
  end

  def flush_db
    @conn.flushdb
  end
end