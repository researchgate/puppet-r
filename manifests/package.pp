define r::package($r_path = "/usr/bin/R", $repos = "'http://cran.rstudio.com'", $dependencies = false) {

  $depopt = $dependencies ? {
    true => 'TRUE',
    default => 'FALSE'
  }

   # FIXME - we need to build a proper array of repositories
   #  $repostring = join($repos.map |key| { "'$key'"}, ",")

  exec { "install_r_package_$name":
    command => "$r_path -e \"install.packages('$name', repos=c($repos), dependencies = $depopt)\"",
    unless  => "$r_path -q -e '\"$name\" %in% installed.packages()' | grep 'TRUE'",
    timeout => 1800,
    require => Class['r']
  }

}
