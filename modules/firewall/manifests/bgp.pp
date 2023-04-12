# Defines the rules necessary for BGP
class firewall::bgp () {
  include firewall::iptables

  $services = [
    {
      name => 'BGP',
      protocol => 'tcp',
      port => '179',
    },
  ]
  file { '/etc/iptables.d/bgpd.iptables.data':
    content => template('firewall/services.iptables.data.erb'),
    owner   => root,
    group   => root,
    mode    => '0500',
    notify  => Exec['refreshFirewall'],
  }
}
