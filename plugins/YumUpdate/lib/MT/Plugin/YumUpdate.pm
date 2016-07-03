package MT::Plugin::YumUpdate;
use strict;
use warnings;

use MT;
use MT::Author;

use MT::Plugin::YumUpdate::Command;
use MT::Plugin::YumUpdate::Mail;

sub code {
    my $yum_update = MT::Plugin::YumUpdate::Command->new;
    $yum_update->run;
    if ( $yum_update->is_updated ) {
        _write_log( $yum_update->log );
        if ( my $su = &_superuser_exists ) {
            MT::Plugin::YumUpdate::Mail->send( $su->email, $yum_update->log );
        }
    }
    1;
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

sub _superuser_exists {
    my $iter = MT::Author->load_iter( undef, { sort => 'id' } );
    while ( my $user = $iter->() ) {
        return $user if $user->is_superuser;
    }
    undef;
}

1;

