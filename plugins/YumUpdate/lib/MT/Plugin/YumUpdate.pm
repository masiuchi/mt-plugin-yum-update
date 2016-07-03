package MT::Plugin::YumUpdate;
use strict;
use warnings;

use MT;
use MT::Mail;

sub code {
    my $log = _yum_update();
    if ( _packages_were_updated($log) ) {
        _write_log($log);
        if ( my $user = &_superuser ) {
            _send_mail( $user, $log );
        }
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

sub _send_mail {
    my ( $user, $log ) = @_;
    my $header = _mail_header($user);
    MT::Mail->send( $header, $log );
}

sub _mail_header {
    my $user = shift;
    +{  From    => $user->email,
        To      => $user->email,
        Subject => 'yum update log',
    };
}

sub _superuser {
    my $user = MT->model('author')
        ->load( undef, { sort => 'id', direction => 'descend', limit => 1 } );
    $user;
}

1;

