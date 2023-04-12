# Enables rules for ssh access
class firewall::ssh () {
  include firewall::iptables

  $services = [
    {
      name     => 'SSH',
      protocol => 'tcp',
      port     => '22',
    },
  ]
  file { '/etc/iptables.d/ssh.iptables.data':
    content => template('firewall/services.iptables.data.erb'),
    owner   => root,
    group   => root,
    mode    => '0500',
    notify  => Exec['refreshFirewall'],
  }
}
