#!/usr/bin/perl-w
use strict;
use warnings;
#explanation:this program is edited to
#edit by Lvjun;   Tue Apr 27 17:03:19 CST 2010
#Version 1.0    hewm@genomics.org.cn

die  "Version 1.0\t2010-04-27;\nUsage: $0 <InPut_1:total_filtered_snp><InPut_2:pop1_rawsnp><OutDir:pop2_rawsnp><outdir>\n" unless (@ARGV ==4);

#############Befor  Start  ,open the files #########################

open     SNP,"$ARGV[0]"  || die "input file can't open $!" ;
open     POP1,"$ARGV[1]"  || die "input file can't open $!" ;
open     POP2,"$ARGV[2]"  || die "input file can't open $!" ;
open     OutFile,">$ARGV[3]" || die "output file can't open $!" ;


############ Do what you want to do #####################
my %snp_best; my %snp_sec_best;

        while(<SNP>)
        {
                chomp;
                my @inf=split /\t/;
		my $pos = $inf[1];
		$snp_best{$pos} = $inf[2];
		$snp_sec_best{$pos} = $inf[3];
        }
	
	while(<POP1>)
	{
		chomp;
		my @inf = split /\t/;
		my $pos = $inf[1];#print OutFile "$inf[1]\n";
		my $rec2 = <POP2>;
		next if(!exists $snp_best{$pos});
		chomp $rec2; my @temp = split /\t/, $rec2;
	        #next if($inf[3] < 3 || $temp[3] < 3);
		my $pos2 =$temp[1];# die "the two population coordinates do not match!\n" if($pos ne $pos2);
		my ($pop1_best_freq, $pop1_sec_best_freq, $pop2_best_freq, $pop2_sec_best_freq); 
		next if( $inf[4]==0 && $inf[6]==0 );
		if($inf[3] eq $snp_best{$pos}) { $pop1_best_freq = $inf[4]/($inf[4]+$inf[6]);}
		elsif($inf[5] eq $snp_best{$pos}) { $pop1_best_freq = $inf[6]/($inf[4]+$inf[6]);}
		else {$pop1_best_freq = 0;}
		if($inf[5] eq $snp_sec_best{$pos}) {$pop1_sec_best_freq = $inf[6]/($inf[4]+$inf[6]);}
		elsif($inf[3] eq $snp_sec_best{$pos}) {$pop1_sec_best_freq = $inf[4]/($inf[4]+$inf[6]);}
		else {$pop1_sec_best_freq = 0;}
		next if(($pop1_best_freq + $pop1_sec_best_freq) < 0.99 );
		next if( $temp[4]==0 && $temp[6]==0 );
		#if($temp[4]==0 && $temp[6]==0){$pop2_best_freq = 0; $pop2_sec_best_freq = 0;}
		if($temp[3] eq $snp_best{$pos}) { $pop2_best_freq = $temp[4]/($temp[4]+$temp[6]);}
                elsif($temp[5] eq $snp_best{$pos}) { $pop2_best_freq = $temp[6]/($temp[4]+$temp[6]);}
                else {$pop2_best_freq = 0;}
                if($temp[5] eq $snp_sec_best{$pos}) {$pop2_sec_best_freq = $temp[6]/($temp[4]+$temp[6]);}
                elsif($temp[3] eq $snp_sec_best{$pos}) {$pop2_sec_best_freq = $temp[4]/($temp[4]+$temp[6]);}
                else {$pop2_sec_best_freq = 0;}
		next if(($pop2_best_freq + $pop2_sec_best_freq) < 0.99 );
	
		print OutFile "$inf[0]\t$inf[1]\t$snp_best{$pos}\t$snp_sec_best{$pos}\t$pop1_best_freq\t$pop1_sec_best_freq\t$pop2_best_freq\t$pop2_sec_best_freq\n";
	}
  seek(POP1,0,0);seek(POP2,0,0);
    #while(<POP1>)
  my ($best1,$best2,$second1,$second2,@pop1_snp,@pop2_snp);my %pop2_site=();
    while(<POP2>)
   {@pop2_snp=split /\t/; $pop2_site{$pop2_snp[1]}=1;}
   while(<POP1>)
   { @pop1_snp=split /\t/; 
     if(!exists $pop2_site{$pop1_snp[1]}){$best1=$pop1_snp[4]/($pop1_snp[4]+$pop1_snp[6]);$second1=$pop1_snp[6]/($pop1_snp[4]+$pop1_snp[6]);$best2=1;$second2=0; print OutFile "$pop1_snp[0]\t$pop1_snp[1]\t$pop1_snp[3]\t$pop1_snp[5]\t$best1\t$second1\t$best2\t$second2\n";}}

  seek(POP1,0,0);seek(POP2,0,0);
  my ($best3,$best4,$second3,$second4);my %pop1_site=();
    while(<POP1>)
   {@pop1_snp=split /\t/; $pop1_site{$pop1_snp[1]}=1;}
   while(<POP2>)
   { @pop2_snp=split /\t/; 
     if(!exists $pop1_site{$pop2_snp[1]}){$best3=$pop2_snp[4]/($pop2_snp[4]+$pop2_snp[6]);$second3=$pop2_snp[6]/($pop2_snp[4]+$pop2_snp[6]);$best4=1;$second4=0; print OutFile "$pop2_snp[0]\t$pop2_snp[1]\t$pop2_snp[3]\t$pop2_snp[5]\t$best4\t$second4\t$best3\t$second3\n";}}
close SNP;
close POP1;
close POP2;
close OutFile ;

