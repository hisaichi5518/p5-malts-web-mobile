#!perl -w
use strict;
use warnings;

package MyApp::Web;
use parent qw(Malts Malts::Web);
use Malts::Web::MobileAgent qw(mobile_agent);
use Malts::Web::MobileCharset;

package main;
use Test::More;

subtest 'testing mobile_agent' => sub {
    my $c = non_mobile_user();
    my $ma  = $c->mobile_agent;

    ok $ma;
    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::NonMobile';

    $c = ezweb_user();
    $ma = $c->mobile_agent;

    ok $ma;
    isa_ok $ma, 'HTTP::MobileAgent';
    isa_ok $ma, 'HTTP::MobileAgent::EZweb';
};

subtest 'testing charset' => sub {
    my $c = non_mobile_user();
    my $ma = $c->mobile_agent;
    is $ma->encoding, 'utf-8';

    $c = ezweb_user();
    $ma = $c->mobile_agent;
    is $ma->encoding, 'x-sjis-ezweb-auto';
};

subtest 'testing mobile charset plugin' => sub {
    my $c = non_mobile_user();
    is $c->html_content_type, "text/html;charset=utf-8";
    isa_ok $c->encoding, 'Encode::utf8';

    $c = ezweb_user();
    is $c->html_content_type, "text/html;charset=Shift_JIS";
    isa_ok $c->encoding, 'Encode::JP::Mobile::_ConvertPictogramSJISkddi-auto';

    $c = docomo_user();
    is $c->html_content_type, "application/xhtml+xml;charset=utf-8";
    isa_ok $c->encoding, 'Encode::XS';
};

subtest 'render_string' => sub {
    my $c = docomo_user();
    my $res = $c->render_string(200, 'testtesttest');
    is_deeply $res->body, ['testtesttest'];
};

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
    $c->create_request($env);
    return $c;
}

done_testing;
