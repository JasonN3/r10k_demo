# Enables rules for zabbix agent
class firewall::zabbix_agent () {
  include firewall::iptables

  $services = [
    {
      name     => 'Zabbix-Agent',
      protocol => 'tcp',
      port     => '10050',
      source   => '192.168.12.0/23',
    },
  ]
  file { '/etc/iptables.d/zabbix-agent.iptables.data':
    content => template('firewall/services.iptables.data.erb'),
    owner   => root,
    group   => root,
    mode    => '0500',
    notify  => Exec['refreshFirewall'],
  }
}
