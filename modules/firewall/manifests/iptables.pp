# Installs iptables
class firewall::iptables () {
  case $facts['os']['family'] {
    'Archlinux': {
      package { 'iptables-services':
        ensure => latest,
        name   => 'iptables',
      }

      package { 'ipset-service':
        ensure => latest,
        name   => 'ipset',
      }
      $firewalld = []
    }
    'RedHat': {
      package { 'iptables-services':
        ensure => latest,
      }

      package { 'ipset-service':
        ensure => latest,
      }
      service { 'firewalld':
        ensure => stopped,
        enable => mask,
      }
      $firewalld = Service['firewalld']
    }
    'Debian': {
      package { 'iptables-services':
        ensure => latest,
        name   => 'iptables-persistent',
      }

      package { 'ipset-service':
        ensure => latest,
        name   => 'ipset-persistent',
      }
      $firewalld = []
    }
    default: {
      fail('Unknown OS')
    }
  }

  service { 'iptables':
    enable => true,
  }

  service { 'ipset':
    enable => true,
  }

  file { '/bin/firewall-update':
    content => template('firewall/firewall-update.erb'),
    owner   => root,
    group   => root,
    mode    => '0500',
    notify  => Exec['refreshFirewall'],
  }

  file { '/etc/iptables.d':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  exec { 'refreshFirewall':
    command     => '/bin/firewall-update',
    require     => [
      Package['iptables-services'],
      Package['ipset-service'],
      $firewalld,
    ],
    refreshonly => true,
  }
}
