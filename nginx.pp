class { 'nginx': }

$webroot = '/var/www/puppet-exercise'
$index_path = "${webroot}/index.html"

package { "curl":
  ensure => "installed"
}

file { $webroot:
  ensure => "directory",
  mode => 755
}

exec { 'get_index':
  command => "/usr/bin/curl https://github.com/puppetlabs/exercise-webpage/blob/master/index.html -o $index_path"
}

file { $index_path:
  require => Exec['get_index']
}

nginx::resource::vhost { 'puppet-exercise':
  before => File[$index_path],
  listen_port => 8000,
  www_root => $webroot
}

