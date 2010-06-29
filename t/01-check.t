use Test::More tests => 1;

use Module::CheckDeps qw(checkdeps);

use strict;

my $code     = "use Some::Module;
		use Another::Module";

my @expected = ('Some::Module', 'Another::Module');

is_deeply(checkdeps($code), \@expected, "Check");
