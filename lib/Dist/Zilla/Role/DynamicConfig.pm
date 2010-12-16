package Dist::Zilla::Role::DynamicConfig;
BEGIN {
  $Dist::Zilla::Role::DynamicConfig::VERSION = '1.001002';
}
BEGIN {
  $Dist::Zilla::Role::DynamicConfig::AUTHORITY = 'cpan:RWSTAUNER';
}
# ABSTRACT: A Role that accepts a dynamic configuration

use strict;
use warnings;
use Moose::Role;


has _config => (
    is       => 'ro',
    isa      => 'HashRef',
    default  => sub { +{} }
);


sub BUILDARGS {
	my ($class, @arg) = @_;
	my %copy = ref $arg[0] ? %{$arg[0]} : @arg;

	my $zilla = delete $copy{zilla};
	my $name  = delete $copy{plugin_name};

	confess 'do not try to pass _config as a build arg!'
		if $copy{_config};

	my $other = $class->separate_local_config(\%copy);

	return {
		zilla => $zilla,
		plugin_name => $name,
		_config     => \%copy,
		%$other
	}
}


requires 'separate_local_config';

no Moose::Role;
1;


__END__
=pod

=for :stopwords Randy Stauner BUILDARGS CPAN AnnoCPAN RT CPANTS Kwalitee diff

=head1 NAME

Dist::Zilla::Role::DynamicConfig - A Role that accepts a dynamic configuration

=head1 VERSION

version 1.001002

=head1 DESCRIPTION

This is a role for a L<Plugin|Dist::Zilla::Role::Plugin>
(or possibly other classes)
that accepts a dynamic configuration.

Plugins performing this role must define L</separate_local_config>.

=head1 ATTRIBUTES

=head2 _config

A hashref where the dynamic options will be stored.

Do not attempt to assign to this from your F<dist.ini>.

=head1 METHODS

=head2 BUILDARGS

Copied/modified from L<Dist::Zilla::Plugin::Prereqs>
to allow arbitrary values to be specified.

This overwrites the L<Class::MOP::Instance> method
called to prepare arguments before instantiation.

It separates the expected arguments
(including anything caught by L</separate_local_config>)
and places the remaining unknown/dynamic arguments into L</_config>.

=head2 separate_local_config

Separate any arguments that should be stored directly on the object
rather than in the dynamic L</_config> attribute.

Remove those arguments from the passed in hashref,
make any necessary modifications (like renaming the keys if desired),
and return a hashref with the result.

Required.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

  perldoc Dist::Zilla::Role::DynamicConfig

=head2 Websites

=over 4

=item *

Search CPAN

L<http://search.cpan.org/dist/Dist-Zilla-Role-DynamicConfig>

=item *

RT: CPAN's Bug Tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dist-Zilla-Role-DynamicConfig>

=item *

AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Dist-Zilla-Role-DynamicConfig>

=item *

CPAN Ratings

L<http://cpanratings.perl.org/d/Dist-Zilla-Role-DynamicConfig>

=item *

CPAN Forum

L<http://cpanforum.com/dist/Dist-Zilla-Role-DynamicConfig>

=item *

CPANTS Kwalitee

L<http://cpants.perl.org/dist/overview/Dist-Zilla-Role-DynamicConfig>

=item *

CPAN Testers Results

L<http://cpantesters.org/distro/D/Dist-Zilla-Role-DynamicConfig.html>

=item *

CPAN Testers Matrix

L<http://matrix.cpantesters.org/?dist=Dist-Zilla-Role-DynamicConfig>

=back

=head2 Bugs

Please report any bugs or feature requests to C<bug-dist-zilla-role-dynamicconfig at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dist-Zilla-Role-DynamicConfig>.  I will be
notified, and then you'll automatically be notified of progress on your bug as I make changes.

=head2 Source Code


L<http://github.com/magnificent-tears/Dist-Zilla-Role-DynamicConfig/tree>

  git clone git://github.com/magnificent-tears/Dist-Zilla-Role-DynamicConfig.git

=head1 AUTHOR

Randy Stauner <rwstauner@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Randy Stauner.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

