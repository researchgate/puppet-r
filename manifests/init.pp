class r (
    $ensure = 'present',
){

    $packagename = $osfamily ? {
        /^(Debian|Ubuntu)$/ => 'r-base',
        'RedHat' => 'R-core',
        default => fail("Not supported on osfamily ${osfamily}")
    }

    if $osfamily =~ /^(Debian|Ubuntu)$/ {
        package { 'r-recommended':
            ensure => $ensure,
        }
    }
    package { $packagename:
        ensure => $ensure,
    }
}
