#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Module::CheckDeps' ) || print "Bail out!
";
}

diag( "Testing Module::CheckDeps $Module::CheckDeps::VERSION, Perl $], $^X" );
