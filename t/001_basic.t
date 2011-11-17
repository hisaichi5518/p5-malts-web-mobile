#!perl -w
use strict;
use Test::More;

use Malts::Web::Request;
use Malts::Web::Request::MobileAgent;
use HTTP::MobileAgent::Plugin::Charset;

subtest 'testing mobile_agent' => sub {
    my $req = non_mobile_user();
    my $ma  = $req->mobile_agent;
    isa_ok $req, 'Malts::Web::Request';
    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::NonMobile';
    is $ma->is_non_mobile, 1;

    $req = ezweb_user();
    $ma = $req->mobile_agent;
    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::EZweb';
    is $ma->is_ezweb, 1;
    return $ma;
};

subtest 'testing charset' => sub {
    my $req = non_mobile_user();
    my $ma = $req->mobile_agent;
    is $ma->encoding, "utf-8";

    $req = ezweb_user();
    $ma = $req->mobile_agent;
    is $ma->encoding, "x-sjis-ezweb-auto";
};

sub ezweb_user {
    Malts::Web::Request->new({HTTP_USER_AGENT => 'KDDI-HI21 UP.Browser/6.0.2.254 (GUI) MMP/1.1'});
}

sub non_mobile_user {
    Malts::Web::Request->new({HTTP_USER_AGENT => 'pc'});
}

done_testing;
