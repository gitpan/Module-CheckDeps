package Module::CheckDeps;
BEGIN {
  $Module::CheckDeps::VERSION = '0.06';
}

use base Exporter;
use Module::ExtractUse;

use warnings;
use strict;

our @EXPORT_OK = qw(checkdeps);

=head1 NAME

Module::CheckDeps - Very simple dependencies checker for Perl code

=head1 VERSION

version 0.06

=head1 SYNOPSIS

Module::CheckDeps parses Perl code, and returns which used modules are
not yet installed.

In comparison to similar modules, such as Module::ScanDeps,
Module::CheckDeps is much more basic and simpler, but also faster.

    use Module::CheckDeps qw(checkdeps);

    my $missing = checkdeps( $code );

=head1 EXPORT

checkdeps will be exported if explicitly specified.

    use Module::CheckDeps qw(checkdeps);

=head1 SUBROUTINES

=head2 checkdeps( $code )

Return an array reference containing packages that need to be installed

=cut

sub checkdeps {
	my $code = shift;

	my $p = Module::ExtractUse -> new;
	$p -> extract_use(\$code);

	my @used = $p -> array;

	my @missing;
	foreach my $module(@used) {
		eval "use $module";
		next if !$@;

		push @missing, $module;
	}

	return \@missing;
}

=head1 AUTHOR

Alessandro Ghedini, C<< <alexbio at cpan.org> >>

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