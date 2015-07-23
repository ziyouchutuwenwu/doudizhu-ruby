require 'pg'
require 'digest'

require_relative "../tools/random_number"
require_relative "../config"

class PgsqlGenTest

  def initialize
    @conn = PG.connect(
        :dbname   => PGSQL_DB_NAME,
        :host     => PGSQL_DB_IP,
        :port     => PGSQL_DB_PORT,
        :user     => PGSQL_USERNAME,
        :password => PGSQL_PASSWORD,
    )
  end

  def set_admin_test_data
    username = 'admin'
    password  = Digest::MD5.hexdigest('admin').upcase
    sql = "INSERT into admins(user_name, password) VALUES ('%s','%s');" % [username,password]
    @conn.exec(sql)
  end

  def set_app_version_test_data
    sql = "INSERT INTO app_versions(platform, app_id, latested_version,url) VALUES ('ios','com.mmcshadow.doudizhu','1.0','http://www.baidu.com');"
    @conn.exec(sql)

    sql = "INSERT INTO app_versions(platform, app_id, latested_version,url) VALUES ('android','com.mmcshadow.doudizhu','1.0','http://www.baidu.com');"
    @conn.exec(sql)

    sql = "INSERT INTO app_versions(platform, app_id, latested_version,url) VALUES ('windows','com.mmcshadow.doudizhu','1.0','http://www.baidu.com');"
    @conn.exec(sql)
  end

  def set_desks_test_data
    # 随机生成三个房间和两个桌子的数
    # for i in 0..2
    #   room_id = RandomNumber.get_random_number
    #   for j in 0..2
    #     desk_id = RandomNumber.get_random_number
    #     sql = "INSERT into desks(desk_id, room_id) VALUES (%s,%s);" % [desk_id,room_id]
    #     @conn.exec(sql)
    #   end
    #   set_rooms_test_data(room_id)
    # end

  room_id = RandomNumber.get_random_number
    desk_id = RandomNumber.get_random_number
    sql = "INSERT into desks(desk_id, room_id) VALUES (%s,%s);" % [desk_id,room_id]
    @conn.exec(sql)
  set_rooms_test_data(room_id)
  end

  def set_rooms_test_data(room_id)
    sql = "INSERT into rooms(room_id, level, description) VALUES ('%s',%d,'%s');" % [room_id,1,"测试数据"]
    @conn.exec(sql)
  end

  #****************************************************************************************************************************************
  # 用户表生成测试数据
  def set_user_table_mass_test_data
    for i in 1..100
      sql = "INSERT INTO users(user_id, user_name, password, gender,device_name,os_name,os_version,device_id,user_type)
VALUES ('%s','user_name', 'myPassword','gender','device_name','os_name','os_version','device_id','guestUser');" % [i]
      @conn.exec(sql)
    end
  end

  # 版本信息表生成测试数据
  def set_version_table_mass_test_data
    for i in 1..100
      sql = "INSERT INTO app_versions(platform, app_id, latested_version,url) VALUES ('ios','com.mmcshadow.doudizhu','%s','http://www.baidu.com');" % [i]
      @conn.exec(sql)
    end
  end

end