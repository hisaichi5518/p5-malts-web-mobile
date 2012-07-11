#!perl -w
use strict;
use Test::More;

BEGIN {
    use_ok "Malts::Web::$_" for qw(MobileAgent MobileCharset);
}

diag "Testing Malts::Web::MobileAgent/$Malts::Web::MobileAgent::VERSION";

done_testing;
