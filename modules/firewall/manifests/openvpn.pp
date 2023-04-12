# Enables rules for openvpn server
class firewall::openvpn {
  include firewall::iptables

  $services = [
    {
      name     => 'OpenVPN-Server',
      protocol => 'udp',
      port     => '1194'
    },
  ]

  file { '/etc/iptables.d/openvpn.iptables.data':
    content => template('firewall/services.iptables.data.erb'),
    owner   => root,
    group   => root,
    mode    => '0500',
    notify  => Exec['refreshFirewall'],
  }
}
