use Test::More tests => 1;

use Module::CheckDeps qw(checkdeps);

use strict;

my $code = <<CODE;
 use PPI;
 use Test::More; # assume this is installed

 use Some::Module;
 use Another::Module;

 print "nothing special to say";
CODE

my @expected = ('Some::Module', 'Another::Module');

is_deeply(checkdeps($code), \@expected, "Testing 'checkdeps()'");
