package MT::Plugin::YumUpdate;
use strict;
use warnings;

use MT;

sub code {
    my @logs = `sudo yum -y update 2>&1`;
    my $log = join "\n", @logs;
    if ($log !~ /No Packages marked for update/m) {
        MT->log(
            {   message  => 'Updated yum packages',
                category => 'yum update',
                metadata => $log,
            }
        );
    }
    1;
}

1;

