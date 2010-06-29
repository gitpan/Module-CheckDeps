use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Module::CheckDeps',
    AUTHOR              => q{Alessandro Ghedini <alexbio@cpan.org>},
    VERSION_FROM        => 'lib/Module/CheckDeps.pm',
    ABSTRACT_FROM       => 'lib/Module/CheckDeps.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    EXE_FILES	=> ['script/checkdeps'],
    PREREQ_PM => {
        'Test::More'         => 0,
        'Module::ExtractUse' => 0,
        'Getopt::Long'	     => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Module-CheckDeps-*' },
);
