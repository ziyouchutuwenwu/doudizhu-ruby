require_relative "./pgsql/pgsql_gen_test"

def set_test_data
  pgsql = PgsqlGenTest.new
  pgsql.set_admin_test_data
  pgsql.set_app_version_test_data
  pgsql.set_desks_test_data
end

def set_backend_test_data
  pgsql = PgsqlGenTest.new

  pgsql.set_admin_test_data

  pgsql.set_user_table_mass_test_data
  pgsql.set_version_table_mass_test_data
end