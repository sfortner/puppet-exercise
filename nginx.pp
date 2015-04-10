class { 'nginx': }

$webroot = '/var/www/puppet-exercise'
$index_path = "${webroot}/index.html"

file { ['/var/www/', $webroot]:
  ensure => "directory",
  mode => 755
}

exec { 'get_index':
  require => File[$webroot],
  command => "/usr/bin/wget https://github.com/puppetlabs/exercise-webpage/blob/master/index.html -O ${index_path}"
}

file { $index_path:
  require => Exec['get_index']
}

nginx::resource::vhost { 'puppet-exercise':
  before => File[$index_path],
  listen_port => 8000,
  www_root => $webroot
}
