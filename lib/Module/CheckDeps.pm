package Module::CheckDeps;
BEGIN {
  $Module::CheckDeps::VERSION = '0.08';
}

use PPI;
use base Exporter;

use warnings;
use strict;

our @EXPORT_OK = qw(alldeps checkdeps);

=head1 NAME

Module::CheckDeps - Very simple dependencies checker for Perl code

=head1 VERSION

version 0.08

=head1 SYNOPSIS

    use Module::CheckDeps qw(alldeps checkdeps);

    my $all     = alldeps( $code );
    my $missing = checkdeps( $code );

=head1 DESCRIPTION

B<Module::CheckDeps> parses Perl code searching for used modules. It can either
return a list of all the modules used by some code, or a list of the used
modules that are not available in the host system (e.g. not installed modules).

Compared to similar modules, such as L<Module::ScanDeps>, B<Module::CheckDeps>
is simpler and less powerful, but also much faster.

=head1 EXPORT

C<checkdeps> and C<alldeps> will be exported if explicitly specified.

=head1 SUBROUTINES

=head2 alldeps( $code )

Return an array reference containing all the used packages

=cut

sub alldeps {
	my $code = shift;

	my $doc = PPI::Document -> new(\$code);
	my $includes = $doc -> find(sub {
		$_[1] -> isa('PPI::Statement::Include')  and
		($_[1] -> type eq 'use' or $_[1] -> type eq 'require')
	});

	my @modules = map {$_ -> module} @$includes;

	return \@modules;
}

=head2 checkdeps( $code )

Return an array reference containing packages that need to be installed

=cut

sub checkdeps {
	my $code = shift;

	my $modules = alldeps($code);

	my @missing;
	foreach my $module(@$modules) {
		eval "use $module";
		next if !$@;

		push @missing, $module;
	}

	return \@missing;
}

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 SEE ALSO

L<Module::ScanDeps>

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Module::CheckDeps