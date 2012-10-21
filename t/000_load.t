#!perl -w
use strict;
use Test::More;

BEGIN {
    use_ok "Malts::Plugin::Web::$_" for qw(MobileAgent MobileCharset);
}

diag "Testing Malts::Plugin::Web::MobileAgent/$Malts::Plugin::Web::MobileAgent::VERSION";

done_testing;
