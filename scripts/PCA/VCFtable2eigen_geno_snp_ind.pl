#!/usr/bin/perl -w 

# Read a vcf file and extract useful inforamtion into a new file
###################################
# write by Zhengkui Zhou 8-7-2012 #
###################################
use warnings;
use strict;

# Declare and initialize variables 
my @file1_data1 = (  ); 
my $file1_data1;
my @file1_data2 = (  ); 
my $file1_data2;

#my $infil1="IGDB-TZX-S600.filtered.snp.txt";
#my $outfil1="IGDB-TZX-S601e.geno";
#my $outfil2="IGDB-TZX-S601e.snp";

#open (INFIL1, $infil1)  or die " can not open file $infil1 \n" ;
#open (OUTFIL, ">$outfil")  or die " can not open file $outfil \n" ;

die  "Version 1.0\t2013-07-05;\nUsage: $0 <InPut_1:snp table><OutDir1:geno><OutDir2:snp><OutDir3:ind>\n" unless (@ARGV ==4);

open     INFile1,"$ARGV[0]"  || die "input file can't open $!" ;
open     OutFile1,">$ARGV[1]" || die "output file can't open $!" ;
open     OutFile2,">$ARGV[2]" || die "output file can't open $!" ;
open     OutFile3,">$ARGV[3]" || die "output file can't open $!" ;

@file1_data1 = <INFile1>; 
my $query1 = @file1_data1;
my $i = 0;
my $SNP;
close  INFile1;
##### ind output ######
for ($i=0; $i<1; $i++)   # care the start line number;
{
    my @temp1 = split (/\s+/, $file1_data1[$i]);
    my $temp1_len = @temp1 ;
        my $m ;
        #print OutFile3 "IGDB-TZX-513\tU\tControl\n";
        for ($m=0; $m<($temp1_len-6); $m++)  ## NO addtail in last column in first row
        {
            my @ind = split (/\s+/, $temp1[$m+6]);
            $ind[0] =~ s/\.GT//;
            print OutFile3 "$ind[0]\tU\tControl\n";
        }
}
##### geno output ######
my $n = 1;
for ($i=1; $i<$query1; $i++)   # care the start line number;
{
    my @temp1 = split (/\s+/, $file1_data1[$i]);
    my $temp1_len = @temp1 ;
    my $miss=0;    
    my $threshold = ($temp1_len-6)/3;
        for ( my $j=6; $j<=$temp1_len-6; $j++)   # care the start line number;
        {
            if ($temp1[$j] eq "./.")
            {
             $miss++   
            }
        }
            if ($miss < $threshold)
            {
    
        my $leftmost= ($temp1_len-6)*2*0.1;
        my $rightmost= ($temp1_len-6)*2*0.9;
        #print "$leftmost $rightmost\n";
        next if ($temp1[5]>$rightmost);
        next if ($temp1[5]<$leftmost);
    
                my $Ref="$temp1[2]$temp1[2]";
                my $Alt="$temp1[3]$temp1[3]";
                #print OutFile1 "2";  ##Ref-genome;
        my $m ;
        for ($m=0; $m<($temp1_len-6); $m++)  ## minus 1 is need! For addtail info at last column
        {
            my @snp = split (/\s+/, $temp1[$m+6]);
                $snp[0] =~ s/\///;
                if ($snp[0] eq $Ref )
                {
                    $SNP="2"   
                }
                elsif ( $snp[0] eq "..")
                {
                    $SNP="9"   
                }
                elsif ($snp[0] eq $Alt)
                {
                    $SNP="0"   
                }
                else
                {
                    $SNP="1"   
                }
                #print genotype for each samples;
                print OutFile1 "$SNP";
        }
       print OutFile1 "\n";
##### snp output ######
        $temp1[0] =~ s/chr//;
        print OutFile2 "sy$n $temp1[0] 0.0. $temp1[1] $temp1[2] $temp1[3]\n";
        $n ++;
}
}
close (OutFile1) or die( "Cannot close file : $!");
close (OutFile2) or die( "Cannot close file : $!");
