use strict;
use warnings;
BEGIN {
    unshift @INC, 'inc';

    # author requires, or bundled modules
    my @devmods = (
        'inc::Module::Install'         => [1.06],
        'Module::Install::AuthorTests' => [0.002],
        'Malts' => [
            0.800,
            'https://github.com/malts/p5-malts/tarball/master'
        ],
    );
    my @not_available;
    while(my($mod, $args) = splice @devmods, 0, 2) {
        my $ver = $args->[0];
        my $uri = $args->[1];
        eval qq{use $mod $ver (); 1} or push @not_available, $uri ? $uri : $mod;
    }

    if(@not_available) {
        print qq{# The following modules are not available.\n};
        print qq{# `perl $0 | cpanm` will install them:\n};
        print $_, "\n" for @not_available;
        exit 1;
     }
}
use inc::Module::Install;

all_from 'lib/Malts/Plugin/Web/MobileAgent.pm';

requires 'HTTP::MobileAgent';
requires 'HTTP::MobileAgent::Plugin::Charset';
requires 'Encode::JP::Mobile';

test_requires 'Test::More' => '0.88';

tests_recursive;
author_tests 'xt';


clean_files qw(
    Malts-Web-MobileAgent-*
    *.stackdump
    cover_db *.gcov *.gcda *.gcno
    nytprof
    *.out
);

WriteAll(check_nmake => 0);
