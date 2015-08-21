class r (
    $ensure = 'present',
){

    $packagename = $osfamily ? {
        /^(Debian|Ubuntu)$/ => 'r-base',
        'RedHat' => 'R-core',
        default => fail("Not supported on osfamily $osfamily")
    }

    package { $packagename:
        ensure => $ensure,
    }
}