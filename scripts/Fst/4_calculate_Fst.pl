#!/usr/bin/perl-w
use strict;
use warnings;
#explanation:this program is edited to soybean
#edit by Lvjun;   Tue Apr 27 17:03:19 CST 2010
#Version 1.0    hewm@genomics.org.cn

die  "Version 1.0\t2010-04-27;\nUsage: $0 <InPut_1:allele_freq_file><pop1_size><pop2_size><sliding_win_len><sliding_step_len><OutDir_site><OutDir_Fst_win><chr>\n" unless (@ARGV ==8);

#############Befor  Start  ,open the files #########################

open     INFile,"$ARGV[0]"  || die "input file can't open $!" ;
open     OutFile,">$ARGV[5]" || die "output file can't open $!" ;
open     Out_Win,">$ARGV[6]" || die "output file can't open $!" ;
my %chr_len = ("chromosome1" => 198279714, "chromosome2" => 154284905, "chromosome3" => 115726694, "chromosome4" => 74522697, "chromosome5" => 63518290, "chromosome6" => 36432895, "chromosome7" => 39267675, "chromosome8" => 31227811, "chromosome9" => 26143058, "chromosome10" => 18705356, "chromosome11" => 21689149, "chromosome12" => 20948878, "chromosome13" => 21836115, "chromosome14" => 19493316, "chromosome15" => 17611747, "chromosome16" => 15016072, "chromosome17" => 387063, "chromosome18" => 11812398, "chromosome19" => 12467614, "chromosome20" => 11802570, "chromosome21" => 15674435, "chromosome22" => 7938656, "chromosome23" => 4481959, "chromosome24" => 7225183, "chromosome25" => 7330073, "chromosome26" => 1284139, "chromosome27" => 6461911, "chromosome28" => 4767862, "chromosome29" => 4453915,  "chromosome30" => 74036464, "chromosome31" => 1096236, "chromosome32" => 41995137,  "chromosomeZ" => 74036464, "chromosomeW" => 1096236, "chromosomeU" => 41995137 );

############ Do what you want to do #####################
my $pop1_size = $ARGV[1];
my $pop2_size = $ARGV[2];
my $w_pop1 = $ARGV[1]/($ARGV[1]+$ARGV[2]);
my $w_pop2 = $ARGV[2]/($ARGV[1]+$ARGV[2]);
my %site_Fst;
my $chr=$ARGV[7];
#$chr=~ s/chromosome0//;
$chr=~ s/chromosome//;
        while(<INFile>)
        {
                chomp ;
                my @inf=split /\t/;
		my ($Hs,$Ht,$Xa,$Xb,$Fst_site);
		$Hs = 1 - ($w_pop1*($inf[4]**2+$inf[5]**2) + $w_pop2*($inf[6]**2+$inf[7]**2));
		$Xa = $w_pop1*$inf[4] + $w_pop2*$inf[6];
		$Xb = $w_pop1*$inf[5] + $w_pop2*$inf[7];
		$Ht = 1 - ($Xa**2 + $Xb**2);
		next if($Ht == 0);
		$Fst_site = ($Ht - $Hs)/$Ht;
		print OutFile "$chr\t$inf[0]\t$inf[1]\t$Fst_site\n";
		$site_Fst{$inf[1]} = $Fst_site;
        }

	for(my $i = 1; $i <= ($chr_len{$ARGV[7]} - $ARGV[3] + $ARGV[4]); $i += $ARGV[4])
        {
                my $left = $i;
                my $right = $i + $ARGV[3] - 1;
                my $sum_Fst = 0;
                my $snp_num = 0;
                for(my $m = $left; $m <= $right; $m++)
                {
                next if(!exists $site_Fst{$m});
                $snp_num++;
                $sum_Fst += $site_Fst{$m};
                }
                next if($snp_num==0);
                my $win_Fst = $sum_Fst/$snp_num;
                print Out_Win "$chr\t$left\t$right\t$win_Fst\n";
		#print Out_Win "$left\t$right\t$win_Fst\n";

        }


close INFile;
close OutFile ;
close Out_Win;

