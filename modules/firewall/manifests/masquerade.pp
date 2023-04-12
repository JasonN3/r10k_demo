# Configures masquerading
# @param interfaces
#   interfaces to masquerade
class firewall::masquerade (
  Array $interfaces
) {
  include firewall::iptables

  file { '/etc/iptables.d/masquerade.iptables.data':
    content => template('firewall/masquerade.iptables.data.erb'),
    owner   => root,
    group   => root,
    mode    => '0500',
    notify  => Exec['refreshFirewall'],
  }
}
