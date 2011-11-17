#!perl -w
use strict;
use Test::More;

use Malts::Web::Request;
use Malts::Web::Request::MobileAgent;

subtest 'testing mobile_agent' => sub {
    my $req = Malts::Web::Request->new({HTTP_USER_AGENT => 'docomo'});
    my $ma  = $req->mobile_agent;
    isa_ok $req, 'Malts::Web::Request';
    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::NonMobile';
    is $ma->is_non_mobile, 1;

    $req = Malts::Web::Request->new({HTTP_USER_AGENT => 'KDDI-HI21 UP.Browser/6.0.2.254 (GUI) MMP/1.1'});
    $ma  = $req->mobile_agent;
    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::EZweb';
    is $ma->is_ezweb, 1;
};

done_testing;
