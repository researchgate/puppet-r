define r::package ($r_path = '/usr/bin/R', $repos = ['http://cran.rstudio.com'], $dependencies = false) {
    $depopt = $dependencies ? {
        true    => 'TRUE',
        default => 'FALSE'
    }

    if is_string($repos) {
        $repoarray = [$repos]
    }

    if is_array($repos) {
        $repoarray = $repos
    }

    # turns array ['http://foo', 'http://bar'] into string: "'http://foo','http://bar'"
    $repostring = join(suffix(prefix($repoarray, '\''), '\''), ',')

    # FIXME: install failures are not caught at the moment
    # FIXME: We might need to turn this into a proper provider.
    exec { "install_r_package_${name}":
        command => "${r_path} -e \"install.packages('${name}', repos=c(${repostring}), dependencies = ${depopt})\"",
        unless  => "${r_path} -q -e \"system.file(package = '${name}')\" | /bin/egrep -qo '/${name}'",
        timeout => 1800,
        require => Class['r']
    }
}
