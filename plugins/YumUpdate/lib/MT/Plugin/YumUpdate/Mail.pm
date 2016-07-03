package MT::Plugin::YumUpdate::Mail;
use strict;
use warnings;

use MT::Mail;

use constant SUBJECT => 'yum update log';

sub send {
    my ( $class, $email, $body ) = @_;
    return unless $email;
    my $headers = _headers($email);
    MT::Mail->send( $headers, $body );
}

sub _headers {
    my $email = shift;
    +{  From    => $email,
        To      => $email,
        Subject => SUBJECT,
    };
}

1;

