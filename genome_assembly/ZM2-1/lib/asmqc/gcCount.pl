#!/usr/bin/perl -w
#
# ====================================================================================================
# File: gcCount.pl
# Author: Sanzhen Liu
#
# This file count the gc content of each sequence in the input file if not specify the option --average. 
# If the option --average is specified, the average size will be informed.
# 
# Usage: perl gcCount.pl <Input Fasta File> [--average] [--help]
# --average: if it is specified, it count the average gc% for all sequences. if it's not specified, 
# gc% will be counted for each individual sequence.
# ====================================================================================================

use strict;
use warnings;
use Getopt::Long;

my %seq_size;
my %seq_gc;
my $seq;
my $size;
my $help;
my $average; 
my $total;
my $total_gc;
my $count;
my $size_gc;

sub prompt {
	print <<EOF;
	Usage: perl gcCount.pl <Input Fasta File> [--all] [--average]
	This file count the gc content of each sequence in the input file if not specify the option --average.
	If the option --average is specified, the average size will be informed.
	[--average]: if it is specified, it count the average gc% for all sequences. if it's not specified, 
	gc% will be counted for each individual sequence.
	[--help]: if it's specified, print the help information.
EOF
exit;
}
# read the parameters:
&GetOptions("help" => \$help, "average" => \$average) || &prompt;

if ($help) {
	&prompt;
}

# open file to count the gc content:
open(IN, $ARGV[0]) || die "Cannot open $ARGV[0].\n";

# Read all sequence (name and size) into hash;
while (<IN>) {
   chomp;
   if (/^>(.+)/) {
      if (defined $seq) {
         $seq_size{$seq} = $size;
		 $seq_gc{$seq} = $size_gc;
      }
      $seq = $1;
      $size = 0;
	  $size_gc = 0;
   }
   else { 
	  my $sudo = uc($_);
	  $sudo =~ s/N//ig;
	  $size += length($sudo);
	  $sudo =~ s/[AT]//ig;
	  $size_gc += length($sudo);
   }
}
# last element:
$seq_size{$seq} = $size;
$seq_gc{$seq} = $size_gc;
close IN;

# output according to the option input:
if ($average) {
	foreach (keys %seq_size) {
		$total += $seq_size{$_};
		$total_gc += $seq_gc{$_};
	}
	printf("%s\t%.1f\n","GC%=",100*$total_gc/$total);
} else {
	foreach (keys %seq_size) {
		printf("%s\t%.1f\n", $_ ,100*$seq_gc{$_}/$seq_size{$_});
	}
}
