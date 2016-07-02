package MT::Plugin::YumUpdate;
use strict;
use warnings;

use MT;

sub code {
    my $log = _yum_update();
    if ( _packages_were_updated($log) ) {
        _write_log($log);
    }
    1;
}

sub _yum_update {
    my @logs = `sudo yum -y update 2>&1`;
    join "\n", @logs;
}

sub _packages_were_updated {
    my $log = shift;
    $log =~ /No Packages marked for update/m ? 0 : 1;
}

sub _write_log {
    my $log = shift;
    MT->log(
        {   message  => 'Updated yum packages',
            category => 'yum update',
            metadata => $log,
        }
    );
}

1;

