define r::package($r_path = "/usr/bin/R", $repos = ["http://cran.rstudio.com"], $dependencies = false) {

  $depopt = $dependencies ? {
    true => 'TRUE',
    default => 'FALSE'
  }

  $repostring = join($repos.map |key| { "'$key'"}, ",")

  exec { "install_r_package_$name":
    command => "$r_path -e \"install.packages('$name', repos=c($repostring), dependencies = $depopt)\"",
    unless  => "$r_path -q -e '\"$name\" %in% installed.packages()' | grep 'TRUE'",
    require => Class['r']
  }

}
