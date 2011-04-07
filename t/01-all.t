use Test::More tests => 1;

use Module::CheckDeps qw(alldeps);

use strict;

my $code = <<CODE;
 use PPI;
 use Test::More;

 use Some::Module;
 use Another::Module;

 print "nothing special to say";
CODE

my @expected = ('PPI', 'Test::More', 'Some::Module', 'Another::Module');

is_deeply(alldeps($code), \@expected, "Testing 'alldeps()'");
