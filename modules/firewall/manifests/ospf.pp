# Enables rules for ospf
class firewall::ospf () {
  include firewall::iptables

  $services = [
    {
      name     => 'OSPF',
      protocol => '89',
    },
  ]
  file { '/etc/iptables.d/ospfd.iptables.data':
    content => template('firewall/services.iptables.data.erb'),
    owner   => root,
    group   => root,
    mode    => '0500',
    notify  => Exec['refreshFirewall'],
  }
}
