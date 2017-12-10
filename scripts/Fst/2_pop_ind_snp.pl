#!/usr/bin/perl -w
#this program is edit by gouzhiheng
#is edited to make pop_snp
#2012/3/6

die " Usage: $0 <input_01><input_02><output><the_number_pop_1><the_number_pop_2>" unless(@ARGV==5);
#open FILE_pop,"<$ARGV[0]" || die" cannot open sort_pop.";
%file_pop=();
%file_pop_1=();
#while(<FILE_pop>)
#{ chomp; 
#  @file00=split / /;
#  $file_pop{$file00[1]}=1;

#}
open FILE02,"<$ARGV[1]" || die "cannot open input_02";
open FILE01,"<$ARGV[0]" || die "cannot open input_01";
open OUTFILE,">$ARGV[2]" || die "cannot open output";
while(<FILE01>){ @file00=split /\t/;$file_pop{$file00[1]}=1;}
 #if(exists $file_pop{$file01[1]})
 while(<FILE02>){@file0=split /\t/;if(!exists $file_pop{$file0[1]}){$file_pop{$file0[1]}=1;}}

seek(FILE01,0,0);
seek(FILE02,0,0);
while(<FILE01>)
{@file01=split /\t/;
  while(<FILE02>)
 {  
    @file02=split /\t/;
    #$file_pop_1{$file02[1]}=1;
 if(exists $file_pop{$file02[1]})
  {  #   @file02=split /\t/;
      if($file01[1]==$file02[1])
   { if($file01[3]eq $file02[3] and $file01[5]eq $file02[5])
    {  $best=$file01[4]+$file02[4];
            $second=$file01[6]+$file02[6];
            print OUTFILE "$file01[0]\t$file01[1]\t$file01[3]\t$file01[5]\t$best\t$second\n";  
last;
    }
elsif($file01[3]eq $file02[5] and $file01[5]eq $file02[3])
    {$best1=$file01[4]+$file02[6];$second1=$file01[6]+$file02[4];
  if($best1>$second1){ print OUTFILE "$file01[0]\t$file01[1]\t$file01[3]\t$file01[5]\t$best1\t$second1\n";}
  else{print              OUTFILE "$file01[0]\t$file01[1]\t$file01[5]\t$file01[3]\t$second1\t$best1\n";}
    }
elsif($file01[3]eq $file02[3] and $file01[5]ne $file02[5])
    {if($file01[6]>$file02[6]){$best2=$file01[4]+$file02[4]+$file02[6];$second2=$file01[6];print OUTFILE "$file01[0]\t$file01[1]\t$file01[3]\t$file01[5]\t$best2\t$second2\n";}
 else{$best2=$file01[4]+$file02[4]+$file01[6];$second2=$file02[6]; print OUTFILE "$file01[0]\t$file02[1]\t$file02[3]\t$file02[5]\t$best2\t$second2\n";}
    }
elsif($file01[3]eq $file02[5] and $file01[5]ne $file02[3])
    {$best3=$file01[4]+$file01[6]+$file02[6];$second3=$file02[4];
 if($best3>$second3){ print OUTFILE "$file01[0]\t$file01[1]\t$file01[3]\t$file02[3]\t$best3\t$second3\n";}
    else{            print OUTFILE "$file01[0]\t$file01[1]\t$file02[3]\t$file01[3]\t$second3\t$best3\n";}
    }
elsif($file01[3]ne $file02[5] and $file01[5]eq $file02[3])
    { $best4=$file02[4]+$file02[6]+$file01[6];$second4=$file01[4];
 if($best4>$second4){   print OUTFILE "$file01[0]\t$file01[1]\t$file01[5]\t$file01[3]\t$best4\t$second4\n";}
 else{            print OUTFILE "$file01[0]\t$file01[1]\t$file01[3]\t$file01[5]\t$second4\t$best4\n";}    
    }
else{ $best5=$file01[4]+$file01[6];$second5=$file02[4]+$file02[6];
      if($best5>$second5){ print OUTFILE "$file01[0]\t$file01[1]\t$file01[3]\t$file02[3]\t$best5\t$second5\n";}
    else{            print OUTFILE "$file01[0]\t$file01[1]\t$file02[3]\t$file01[3]\t$second5\t$best5\n";} 
    }

  }last;
 }seek(FILE02,0,1)
} seek(FILE01,0,1); }

seek(FILE01,0,0);
seek(FILE02,0,0);
while(<FILE01>)
{@file03=split /\t/;$file_pop_1{$file03[1]}=1;}
while(<FILE02>){@file04=split /\t/;if(!exists $file_pop_1{$file04[1]}){$best7=$file04[4]+$ARGV[3]*2;$second7=$file04[6];print OUTFILE "$file04[0]\t$file04[1]\t$file04[3]\t$file04[5]\t$best7\t$second7"}}
seek(FILE01,0,0);
seek(FILE02,0,0);
while(<FILE02>){@file05=split /\t/;$file_pop_2{$file05[1]}=1;}
while(<FILE01>){@file06=split /\t/;
if(!exists $file_pop_2{$file06[1]}){$best6=$file06[4]+$ARGV[4]*2;$second6=$file06[6]; print OUTFILE "$file06[0]\t$file06[1]\t$file06[3]\t$file06[5]\t$best6\t$second6";}
}
close OUTFILE;
close FILE02;
close FILE01;
  
