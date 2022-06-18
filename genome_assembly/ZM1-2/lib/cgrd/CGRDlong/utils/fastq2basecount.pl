#!/usr/bin/perl -w

use warnings;
use strict;

foreach my $input (@ARGV) {
	my $bases = 0;
	open(IN, $input) || die;
	while (<IN>) {
		chomp;
		if (/^[AGCTNacgtn]+$/) {
			$bases += length($_);
		}
	}
	print "$input\t$bases\n";
	$bases = 0;
}
