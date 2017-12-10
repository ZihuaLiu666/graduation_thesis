#!/usr/bin/perl -w 

# Read a vcf table file and extract data for XP-CLR snp file.
###################################
# write by Zhengkui Zhou 20-06-2013 #
###################################
use warnings;
use strict;

# Declare and initialize variables 
my @file1_data1 = (  ); 
my $file1_data1;
my @file1_data2 = (  ); 
my $file1_data2;

die  "Version 1.0\t2013-07-29;\nUsage: $0 <InPut_1:origin base-file><OutDir:base major allele changed format>\n" unless (@ARGV ==2);

open     INFile,"$ARGV[0]"  || die "input file can't open $!" ;
open     OutFile,">$ARGV[1]" || die "output file can't open $!" ;

@file1_data1 = <INFile>;  

    my $query1 = @file1_data1;
    my $i = 0;
    close  INFile;

    for ($i=0; $i<$query1; $i++)   # care the start line number;
    {
        my @temp1 = split (/\s+|\t/, $file1_data1[$i]);
        my $temp1_len = @temp1 ;
        my $majorallele= substr($temp1[2],0,1);
        chomp $temp1[6];        
        if($temp1[3] ne $majorallele)
        {
        print OutFile "$temp1[0]\t$temp1[1]\t$temp1[2]\t$temp1[5]\t$temp1[6]\t$temp1[3]\t$temp1[4]";#soja--landrace
        }
        else
        {
        print OutFile "$temp1[0]\t$temp1[1]\t$temp1[2]\t$temp1[3]\t$temp1[4]\t$temp1[5]\t$temp1[6]";#soja--landrace
        }
    print OutFile "\n";
    }     
close (OutFile) or die( "Cannot close file : $!");
