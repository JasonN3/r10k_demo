# Enable rules for ntp server
class firewall::ntp {
  include firewall::iptables

  $services = [
    {
      name     => 'NTP-Server',
      protocol => 'udp',
      port     => '123'
    },
  ]

  file { '/etc/iptables.d/ntp.iptables.data':
    content => template('firewall/services.iptables.data.erb'),
    owner   => root,
    group   => root,
    mode    => '0500',
    notify  => Exec['refreshFirewall'],
  }
}
