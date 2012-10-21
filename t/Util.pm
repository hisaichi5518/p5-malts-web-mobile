package t::Util;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT = qw(ezweb_user docomo_user non_mobile_user request);

sub ezweb_user {
    request({HTTP_USER_AGENT => 'KDDI-HI21 UP.Browser/6.0.2.254 (GUI) MMP/1.1'});
}

sub docomo_user {
    request({HTTP_USER_AGENT => 'DoCoMo/2.0 N901iS(c100;TB;W24H12;ser123456789012345;icc12345678901234567890)'});
}

sub non_mobile_user {
    request({HTTP_USER_AGENT => 'pc'});
}

sub request {
    my $env = shift;
    my $c = MyApp::Web->new;
    $c->{request} = $c->create_request($env);
    return $c;
}


1;
