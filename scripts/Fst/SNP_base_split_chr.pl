#!/usr/bin/perl -w 

use warnings;
use strict;

# Declare and initialize variables 
my @file1_data1 = (  ); 
my $file1_data1;
my @file1_data2 = (  ); 
my $file1_data2;

die  "Version 1.0\t2013-06-29;\nUsage: $0 <InPut_base_file><Split file prefix>\n" unless (@ARGV ==2);

my @files = (  );
@files = qw (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 Z W U);
#my $k = 0;
for (my $k = 0; $k<32; $k++)
{
my $chr=$k + 1;
open OutFile,">$ARGV[1]_$chr.base" || die "output file can't open $!" ;
open INFile1,"$ARGV[0]"  || die "input file can't open $!" ;
@file1_data1 = <INFile1>;  
my $query1 = @file1_data1;
my $j = 0;
    for ($j=0; $j<$query1; $j++)
    {
        chomp $file1_data1[$j];
        my @temp1 = split (/\s+/, $file1_data1[$j]);
        my $temp1_len = @temp1 ;
            if ($temp1[0] eq $files[$k])
            {
              print OutFile "$file1_data1[$j]\n"; 
            }
    }
} 
close (OutFile) or die( "Cannot close file : $!");
