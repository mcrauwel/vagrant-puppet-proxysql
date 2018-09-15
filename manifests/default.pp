node default {
  class { 'proxysql':
    listen_port              => 3306,
    admin_username           => 'admin',
    admin_password           => Sensitive('654321'),
    monitor_username         => 'monitor',
    monitor_password         => Sensitive('123456'),
    override_config_settings => {
      mysql_variables => {
        'monitor_writer_is_also_reader' => false,
      }
    },
  }

  proxy_mysql_user { 'tester':
    ensure            => 'absent',
    password          => mysql_password('tester'),
    default_hostgroup => 1,
    default_schema    => 'test',
  }

  proxy_mysql_user { 'tester1':
    ensure            => 'present',
    password          => mysql_password('tester123'),
    default_hostgroup => 1,
    default_schema    => 'test1',
  }

  proxy_mysql_user { 'tester2':
    ensure            => 'present',
    password          => mysql_password('tester2'),
    default_hostgroup => 2,
    default_schema    => 'test2',
    load_to_runtime   => false,
  }

  proxy_mysql_replication_hostgroup { '10-20':
    ensure           => 'present',
    writer_hostgroup => 10,
    reader_hostgroup => 20,
    comment          => 'Test MySQL Cluster',
  }

  proxy_mysql_replication_hostgroup { '10-30':
    ensure           => 'absent',
    writer_hostgroup => 10,
    reader_hostgroup => 30,
    comment          => 'Test MySQL Cluster',
  }

  proxy_mysql_server { '127.0.0.1:3307-1':
    ensure       => 'present',
    hostname     => '127.0.0.1',
    port         => 3307,
    hostgroup_id => 1,
    status       => 'ONLINE',
    weight       => 1000,
    comment      => 'localhost:3307',
  }

  proxy_mysql_server { '127.0.0.1:3307-2':
    ensure       => 'present',
    hostname     => '127.0.0.1',
    port         => 3307,
    hostgroup_id => 2,
    weight       => 100,
    comment      => 'localhost:3307',
  }

  proxy_mysql_query_rule { 'mysql_query_rule-1':
    rule_id               => 1,
    active                => 1,
    username              => 'tester1',
    match_pattern         => '^SELECT',
    destination_hostgroup => 2,
    apply                 => 1,
  }
}
