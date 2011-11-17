#!perl -w
use strict;
use warnings;

package MyApp::Web;
use parent qw(Malts Malts::Web);

package main;
use Test::More;

use Malts::Web::Request;
use Malts::Web::Request::MobileAgent;
use HTTP::MobileAgent::Plugin::Charset;
use Malts::Plugin::Web::MobileCharset;
use Scope::Container qw(start_scope_container);

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

subtest 'testing mobile charset plugin' => sub {
    my $sc = start_scope_container;
    my $c = MyApp::Web->new;
    $c->{request} = non_mobile_user();

    Malts::Plugin::Web::MobileCharset->init($c, {});
    is $c->html_content_type, "text/html;charset=utf-8";

    $c = MyApp::Web->new;
    $c->{request} = ezweb_user();

    Malts::Plugin::Web::MobileCharset->init($c, {});
    is $c->html_content_type, "text/html;charset=Shift_JIS";

    $c = MyApp::Web->new;
    $c->{request} = docomo_user();

    Malts::Plugin::Web::MobileCharset->init($c, {});
    is $c->html_content_type, "application/xhtml+xml;charset=utf-8";
};


sub ezweb_user {
    Malts::Web::Request->new({HTTP_USER_AGENT => 'KDDI-HI21 UP.Browser/6.0.2.254 (GUI) MMP/1.1'});
}

sub docomo_user {
    Malts::Web::Request->new({HTTP_USER_AGENT => 'DoCoMo/2.0 N901iS(c100;TB;W24H12;ser123456789012345;icc12345678901234567890)'});
}

sub non_mobile_user {
    Malts::Web::Request->new({HTTP_USER_AGENT => 'pc'});
}

done_testing;
