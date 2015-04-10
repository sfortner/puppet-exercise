class { 'nginx': }

$webroot = '/var/www/puppet-exercise'
$index_path = "${webroot}/index.html"

file { ['/var/www/', $webroot]:
  ensure => "directory",
  mode => 755
} ->

exec { 'get_index':
  command => "/usr/bin/wget https://github.com/puppetlabs/exercise-webpage/blob/master/index.html -O ${index_path}"
} ->

nginx::resource::vhost { 'puppet-exercise':
  listen_port => 8000,
  www_root => $webroot
}
