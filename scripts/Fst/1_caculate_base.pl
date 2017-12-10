#!/usr/bin/perl -w
#this program is edited by gouzhiheng
#it is used to caculate ATGC content
#2013/04/28

die "Usage:$0 <input_reads><output_reads>" unless(@ARGV==2);
open FILE_reads,"<$ARGV[0]"or die"cannot open reads file";
open OUT,">$ARGV[1]"or die"cannot open out put";
%base=();
while(<FILE_reads>)
{@base=split /\s/;
my $temp1_len = @base ;
$number_A=0,$number_T=0,$number_G=0,$number_C=0,$base=0;
$best=0,$second=0;

for($j=5;$j<=($temp1_len-1);$j++)
{
if($base[$j] eq "AA"){$number_A++;$number_A++;}
if($base[$j] eq "AT" or $base[$j] eq "TA"){$number_T++;$number_A++;}
if($base[$j] eq "GA" or $base[$j] eq "AG"){$number_G++;$number_A++;}
if($base[$j] eq "AC" or $base[$j] eq "CA"){$number_C++;$number_A++;}
if($base[$j] eq "GG" ){$number_G++;$number_G++;}
if($base[$j] eq "GC" or $base[$j] eq "CG"){$number_C++;$number_G++;}
if($base[$j] eq "GT" or $base[$j] eq "TG"){$number_G++;$number_T++;}
if($base[$j] eq "CC" ){$number_C++;$number_C++;}
if($base[$j] eq "CT" or $base[$j] eq "TC"){$number_C++;$number_T++;}
if($base[$j] eq "TT"){$number_T++;$number_T++;}
}

@unsorted=($number_A,$number_T,$number_G,$number_C);
@sorted=sort {$b <=> $a} @unsorted;

{
if($sorted[0]==$number_A){$best="A";}
if($sorted[1]==$number_A){$second="A";}
if($sorted[0]==$number_G){$best="G";}
if($sorted[1]==$number_G){$second="G";}
if($sorted[0]==$number_T){$best="T";}
if($sorted[1]==$number_T){$second="T";}
if($sorted[0]==$number_C){$best="C";}
if($sorted[1]==$number_C){$second="C";}
}

if($sorted[0]==$number_A and $sorted[0]==$number_T) {$best="A";$second="T";}
if($sorted[0]==$number_A and $sorted[0]==$number_G){$best="A";$second="G";}
if($sorted[0]==$number_A and $sorted[0]==$number_C){$best="A";$second="C";}
if($sorted[0]==$number_T and $sorted[0]==$number_G){$best="T";$second="G";}
if($sorted[0]==$number_T and $sorted[0]==$number_C){$best="T";$second="C";}
if($sorted[0]==$number_T and $sorted[0]==$number_A){$best="T";$second="A";}
if($sorted[0]==$number_G and $sorted[0]==$number_C){$best="G";$second="C";}
if($sorted[0]==$number_G and $sorted[0]==$number_A){$best="G";$second="A";}
if($sorted[0]==$number_G and $sorted[0]==$number_T){$best="G";$second="T";}
if($sorted[0]==$number_C and $sorted[0]==$number_A){$best="C";$second="A";}
if($sorted[0]==$number_C and $sorted[0]==$number_T){$best="C";$second="T";}
if($sorted[0]==$number_C and $sorted[0]==$number_G){$best="C";$second="G";}

if($sorted[1]==0 && $best eq substr($base[1],0,1)){$second=substr($base[1],2,1)}
if($sorted[1]==0 && $best eq substr($base[1],2,1)){$second=substr($base[1],0,1)}

if($sorted[0]!=0) {print OUT "$base[2]\t$base[3]\t$base[1]\t$best\t$sorted[0]\t$second\t$sorted[1]\n";}

if($sorted[0]==0 && $sorted[1]==0) {$best=substr($base[1],0,1);$second=substr($base[1],2,1);
print OUT "$base[2]\t$base[3]\t$base[1]\t$best\t$sorted[0]\t$second\t$sorted[1]\n";}
}
close FILE_reads;
close OUT;
