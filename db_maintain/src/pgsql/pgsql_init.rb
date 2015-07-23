require 'pg'

require_relative "../config"

class PgsqlInit

  def initialize
    @conn = PG.connect(
        :dbname   => PGSQL_DB_NAME,
        :host     => PGSQL_DB_IP,
        :port     => PGSQL_DB_PORT,
        :user     => PGSQL_USERNAME,
        :password => PGSQL_PASSWORD,
    )
  end

  def create_admins_table
    sql = "create table admins
    (
      id serial primary key,
      user_name VARCHAR(10),
      password VARCHAR(50)
    );"
    @conn.exec(sql)
  end

  def drop_admins_table
    sql = "drop TABLE if EXISTS admins;"
    @conn.exec(sql)
  end

  def create_app_versions_table
    sql = "create table app_versions
    (
      id serial primary key,
      platform VARCHAR(10),
      app_id VARCHAR(50),
      latested_version VARCHAR(10),
      url varchar(100)
    );"
    @conn.exec(sql)
  end

  def drop_app_versions_table
    sql = "drop TABLE if EXISTS app_versions;"
    @conn.exec(sql)
  end

  def create_users_table
    sql = "create table users
    (
      user_id VARCHAR(16) primary key,
      user_type varchar(50),
      user_name VARCHAR(50),
      password VARCHAR(50),
      gender VARCHAR(6),

      device_name VARCHAR(50),
      os_name VARCHAR(10),
      os_version VARCHAR(50),
      device_id varchar(50)
    );"
    @conn.exec(sql)
  end

  def drop_users_table
    sql = "drop TABLE if EXISTS users;"
    @conn.exec(sql)
  end

  def create_desks_table
    sql = "create table desks
    (
      id serial primary key,
      desk_id VARCHAR(20),
      room_id VARCHAR(20)
    );"
    @conn.exec(sql)
  end

  def drop_desks_table
    sql = "drop TABLE if EXISTS desks;"
    @conn.exec(sql)
  end

  def create_rooms_table
    sql = "create table rooms
    (
      id serial primary key,
      room_id VARCHAR(16),
      level INTEGER,
      description TEXT
    );"
    @conn.exec(sql)
  end

  def drop_rooms_table
    sql = "drop TABLE if EXISTS rooms;"
    @conn.exec(sql)
  end
end