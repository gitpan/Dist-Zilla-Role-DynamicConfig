#!perl
#
# This file is part of Dist-Zilla-Role-DynamicConfig
#
# This software is copyright (c) 2010 by Randy Stauner.
#
# This is free software; you can redistribute it and/or modify it under
# the same terms as the Perl 5 programming language system itself.
#

use Test::More;

eval "use Test::Synopsis";
plan skip_all => "Test::Synopsis required for testing synopses"
  if $@;
all_synopsis_ok('lib');
