# Ensure timezone is configured
# @param timezone
#   What timezone should be set
class timezone (
  String $timezone
) {
  file { '/etc/localtime':
    ensure => link,
    target => "/usr/share/zoneinfo/${timezone}",
  }
}
