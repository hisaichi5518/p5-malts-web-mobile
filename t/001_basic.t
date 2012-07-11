#!perl -w
use strict;
use warnings;

package MyApp::Web;
use parent qw(Malts Malts::Web);
use Malts::Web::MobileAgent;
use Malts::Web::MobileCharset;

package main;
use t::Util;
use Test::More;

subtest 'testing mobile_agent: non_mobile_user' => sub {
    ok my $ma = non_mobile_user->mobile_agent;

    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::NonMobile';
};

subtest 'testing mobile_agent: ezweb_user' => sub {
    ok my $ma = ezweb_user->mobile_agent;

    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::EZweb';
};

subtest 'testing mobile_agent: docomo_user' => sub {
    ok my $ma = docomo_user->mobile_agent;

    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::DoCoMo';
};

subtest 'testing mobileagent charset: non_mobile_user' => sub {
    ok my $ma = non_mobile_user->mobile_agent;
    is $ma->encoding, 'utf-8';
};

subtest 'testing mobileagent charset: ezweb_user' => sub {
    ok my $ma = ezweb_user->mobile_agent;
    is $ma->encoding, 'x-sjis-ezweb-auto';
};

subtest 'testing mobile charset: non_mobile_user' => sub {
    my $c = non_mobile_user();
    is $c->html_content_type, "text/html;charset=utf-8";
    isa_ok $c->encoding, 'Encode::utf8';
};

subtest 'testing mobile charset: ezweb_user' => sub {
    my $c = ezweb_user();
    is $c->html_content_type, "text/html;charset=Shift_JIS";
    isa_ok $c->encoding, 'Encode::JP::Mobile::_ConvertPictogramSJISkddi-auto';
};


subtest 'testing mobile charset: docomo_user' => sub {
    $c = docomo_user();
    is $c->html_content_type, "application/xhtml+xml;charset=utf-8";
    isa_ok $c->encoding, 'Encode::XS';
};

done_testing;
