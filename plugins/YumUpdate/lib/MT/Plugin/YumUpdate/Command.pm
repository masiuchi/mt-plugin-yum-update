package MT::Plugin::YumUpdate::Command;
use strict;
use warnings;

use constant COMMAND => 'sudo yum -y update 2>&1';

use Class::Accessor 'antlers';
has log => ( is => 'rw', isa => 'Str' );

sub run {
    my $self    = shift;
    my $command = COMMAND;
    my @logs    = `$command`;
    $self->log( join "\n", @logs );
}

sub is_updated {
    my $self = shift;
    $self->log =~ /No Packages marked for update/m ? 0 : 1;
}

1;

