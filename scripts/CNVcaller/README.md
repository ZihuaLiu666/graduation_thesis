# CNVcaller protocol
## Introduction
The DNA sequence along all species chromosomes is constantly changing, and this process enables humans to evolve and adapt. We have long been aware of genetic variation at either size extreme - cytogenetically recognizable segments<sup>1</sup> and single-nucleotide polymorphisms (SNPs)<sup>2</sup>. About 10 years ago, scientists began to recognize abundant variation of an intermediate size class known as structural variation<sup>3-5</sup>. Within this class, copy number variation (CNV), which involves unbalanced rearrangements that increase or decrease the DNA content, accounts for the largest component by far. We now typically define the size of CNVs as larger than 50 bp<sup>6</sup>, whereas smaller elements are known as insertions or deletions (indels). These structural variations encompass more polymorphic base pairs than SNPs by an order of magnitude.

Interested about the [introduction](https://www.nature.com/articles/nrg3871)? See original papers for more details!
1. [Estimates of the frequency of chromosome abnormalities detectable in unselected newborns using moderate levels of banding](http://jmg.bmj.com/content/29/2/103.long)
2. [Initial sequencing and analysis of the human genome](https://www.nature.com/articles/35057062)
3. [Detection of large-scale variation in the human genome](https://www.nature.com/articles/ng1416)
4. [Global variation in copy number in the human genome](https://www.nature.com/articles/nature05329)
5. [Large-scale copy number polymorphism in the human genome](http://science.sciencemag.org/content/305/5683/525.long)
6. [The Database of Genomic Variants: a curated collection of structural variation in the human genome ](https://academic.oup.com/nar/article/42/D1/D986/1068860)
***
* STEP 1: Build reference genome database with customized window size

  example: `perl` `/home/jiangyu/zihua/software/CNVcaller-master/bin/CNVReferenceDB.pl` `/home/jiangyu/zihua/software/CNVcaller-master/29.fa` `-w` `1000`

  Notice: there are another three optional parameters - `-l 0.2 (minimum GC content within a window)`, `-u 0.7 (maximum GC content within a window)` and `-g 0.5 (minimum gap content within a window)`

  you will get a database file:
    * `/home/jiangyu/zihua/software/CNVcaller-master/referenceDB.1000`
    
    Here is the top ten lines of the reference.1000 database file
    ```
    chr   win_num star_pos   GC    repeat   gap 
    ```
    
    ```
    29      1       1       482     129     0.00
    29      2       501     440     504     0.00
    29      3       1001    520     800     0.00
    29      4       1501    578     806     0.00
    29      5       2001    563     778     0.00
    29      6       2501    572     698     0.00
    29      7       3001    572     575     0.00
    29      8       3501    561     636     0.00
    29      9       4001    568     799     0.00
    29      10      4501    554     755     0.00
    ```
***
* STEP 2: Calculate absolute copy number for each window

  Why do we calculate **absolute copy number**?

  example: `bash` `/home/jiangyu/zihua/software/CNVcaller-master/Individual.Process.sh` `-b` `/home/jiangyu/zihua/software/CNVcaller-master/ERR340328.bam` `-h` `ERR340328` `-d` `dupfile` `-s` `X`

  Notice:
    * the `reference.1000` database file should be at your present directory
    * the `-d` link file is specified with window size and species, that is, `human.1000` and `human.800` database files have different link files. Similarly, `human.1000` and `duck.1000` are also different in link files. [Generate your own duplicated window record file (link file)](https://github.com/JiangYuLab/CNVcaller#generate-your-own-duplicated-window-record-file)

  you will get three folders with output files:
    * `/home/jiangyu/zihua/software/CNVcaller-master/RD_raw`
      ```
      |-- ERR340328_raw
      |-- ERR340329_raw
      |-- ERR340330_raw
      |-- ERR340331_raw
      |-- ERR340333_raw
      |-- ERR340334_raw
      |-- ERR340335_raw
      |-- ERR340336_raw
      |-- ERR340338_raw
      `-- ERR340340_raw
      ```
    * `/home/jiangyu/zihua/software/CNVcaller-master/RD_absolute`
      ```
      |-- ERR340328
      |-- ERR340329
      |-- ERR340330
      |-- ERR340331
      |-- ERR340333
      |-- ERR340334
      |-- ERR340335
      |-- ERR340336
      |-- ERR340338
      `-- ERR340340
      ```
    * `/home/jiangyu/zihua/software/CNVcaller-master/RD_normalized`
      ```
      |-- ERR340328_mean_70.70_SD_10.88_sex_1
      |-- ERR340329_mean_62.31_SD_10.62_sex_1
      |-- ERR340330_mean_136.24_SD_14.01_sex_1
      |-- ERR340331_mean_129.28_SD_17.46_sex_1
      |-- ERR340333_mean_69.36_SD_10.29_sex_1
      |-- ERR340334_mean_132.60_SD_14.72_sex_1
      |-- ERR340335_mean_72.20_SD_30.01_sex_1
      |-- ERR340336_mean_72.68_SD_10.06_sex_1
      |-- ERR340338_mean_124.20_SD_13.31_sex_1
      `-- ERR340340_mean_131.67_SD_14.83_sex_1
      ```
***
* STEP 3: Copy number variant region detection

  What is **copy number variant region (CNVR)**?

  example: `bash` `/home/jiangyu/zihua/software/CNVcaller-master/CNV.Discovery.sh` `-l` `/home/jiangyu/zihua/software/CNVcaller-master/list` `-e` `/home/jiangyu/zihua/software/CNVcaller-master/exclude_list` `-f` `0.1` `-h` `1` `-r` `0.5` `-p` `primaryCNVR` `-m` `mergeCNVR`
  
  Notice:
  
    * the `/home/jiangyu/zihua/software/CNVcaller-master/list` of `-l` contains the absolute path of the to be merged files, for example
    * `/home/jiangyu/zihua/software/CNVcaller-master/exclude_list` is a empty file

  ```
  RD_normalized/ERR340328_mean_70.70_SD_10.88_sex_1
  RD_normalized/ERR340329_mean_62.31_SD_10.62_sex_1
  RD_normalized/ERR340330_mean_136.24_SD_14.01_sex_1
  RD_normalized/ERR340331_mean_129.28_SD_17.46_sex_1
  RD_normalized/ERR340333_mean_69.36_SD_10.29_sex_1
  RD_normalized/ERR340334_mean_132.60_SD_14.72_sex_1
  RD_normalized/ERR340335_mean_72.20_SD_30.01_sex_1
  RD_normalized/ERR340336_mean_72.68_SD_10.06_sex_1
  RD_normalized/ERR340338_mean_124.20_SD_13.31_sex_1
  RD_normalized/ERR340340_mean_131.67_SD_14.83_sex_1
  ```
  
  you will get the following two files:
  * `/home/jiangyu/zihua/software/CNVcaller-master/primaryCNVR`
    ```
    chr     start   end     number  gap     repeat  gc      kmer    ERR340328       ERR340329       ERR340330       ERR340331       ERR340333       ERR340334       ERR340335       ERR340336       ERR340338       ERR340340       average sd
    29      18501   21000   4       0.00    0.46    0.57    1       0.82    1.09    0.95    1.15    0.99    0.94    2.73    0.70    0.88    1.00    1.12    0.58
    29      31501   33500   3       0.00    0.51    0.56    1       0.57    1.48    1.06    0.98    0.89    0.92    1.66    1.11    1.00    0.89    1.06    0.31
    29      33501   35500   3       0.00    0.49    0.57    1       0.93    1.58    0.97    0.99    0.89    1.10    1.52    1.11    0.99    1.19    1.13    0.24
    29      88501   91000   4       0.00    0.48    0.58    1       1.23    0.98    0.90    1.11    1.20    1.08    2.84    0.93    1.20    1.04    1.25    0.57
    29      274501  277000  4       0.00    0.44    0.44    1       0.92    0.61    0.61    0.50    0.50    0.45    0.55    0.57    0.59    0.60    0.59    0.13
    ```
  * `/home/jiangyu/zihua/software/CNVcaller-master/mergeCNVR`
    ```
    chr     start   end     number  gap     repeat  gc      kmer    ERR340328       ERR340329       ERR340330       ERR340331       ERR340333       ERR340334       ERR340335       ERR340336       ERR340338       ERR340340       average sd
    29      18501   21000   4       0.00    0.46    0.57    1       0.82    1.09    0.95    1.15    0.99    0.94    2.73    0.70    0.88    1.00    1.12    0.58
    29      31501   35500   6       0.00    0.50    0.57    1.00    0.75    1.53    1.01    0.98    0.89    1.01    1.59    1.11    0.99    1.04    1.09    0.27
    29      88501   91000   4       0.00    0.48    0.58    1       1.23    0.98    0.90    1.11    1.20    1.08    2.84    0.93    1.20    1.04    1.25    0.57
    29      274501  277000  4       0.00    0.44    0.44    1       0.92    0.61    0.61    0.50    0.50    0.45    0.55    0.57    0.59    0.60    0.59    0.13
    29      351501  376500  49      0.00    0.52    0.42    1       0.92    1.62    0.98    0.96    1.47    1.05    2.06    0.98    0.99    0.99    1.20    0.38
    ```
***
* STEP 4: Genotyping

  example: `python` `/home/jiangyu/zihua/software/CNVcaller-master/Genotype.py` `--cnvfile` `mergeCNVR` `--outprefix` `genotypeCNVR` `--nproc 24`
  
  you will get two files:
    * `/home/jiangyu/zihua/software/CNVcaller-master/genotypeCNVR.tsv`
      ```
      chr     start   end     number  gap     repeat  gc      kmer    ERR340328       ERR340329       ERR340330       ERR340331       ERR340333       ERR340334       ERR340335       ERR340336       ERR340338       ERR340340       silhouette_score        calinski_harabaz_score  Log_likelihood  average sd      dd      Ad      AA      AB      BB      BC      M
      29      18501   21000   4       0.0     0.46    0.57    1.0     AA      AA      AA      AA      AA      AA      BC      Ad      AA      AA      0.3752531261841601      7525.499999999985       3.4028975889394166      1.12    0.58    0       1       8       0       0       1       0
      29      31501   35500   6       0.0     0.5     0.57    1.0     Ad      AB      AA      AA      AA      AA      AB      AA      AA      AA      0.6403858269575723      1.0     3.8248610888954095      1.09    0.27    0       1       7       2       0       0       0       0       0
      29      88501   91000   4       0.0     0.48    0.58    1.0     AA      AA      AA      AA      AA      AA      M       AA      AA      AA      0.8250872556146256      1.0     3.8248610888954095      1.25    0.57    0       0       9       0       0       0       1       0       0
      29      274501  277000  4       0.0     0.44    0.44    1.0     AA      Ad      Ad      Ad      Ad      Ad      Ad      Ad      Ad      Ad      0.7361866027071716      1.0     3.9634905250073986      0.59    0.13    0       9       1       0       0       0       0       1       0       0       0
      29      351501  376500  49      0.0     0.52    0.42    1.0     AA      AB      AA      AA      AB      AA      BB      AA      AA      AA      0.7801860378062525      1.0     3.963490525007399       1.2     0.38    0       0       7       2       1       0       0       0       0
      ```
    * `/home/jiangyu/zihua/software/CNVcaller-master/genotypeCNVR.vcf`
      ```
      ##fileformat=VCFv4.2
      ##ALT=<ID=CN0,Description="Copy number allele: 0 copies">
      ##ALT=<ID=CN1,Description="Copy number allele: 1 copy">
      ##ALT=<ID=CN2,Description="Copy number allele: 2 copies">
      ##ALT=<ID=CNH,Description="Copy number allele: more than 2 copies">
      ##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
      ##FORMAT=<ID=CP,Number=1,Type=Float,Description="Normalized copy number">
      ##INFO=<ID=END,Number=1,Type=Integer,Description="End coordinate of this variant">
      ##INFO=<ID=SVTYPE,Number=1,Type=String,Description="Type of structural variant">
      ##INFO=<ID=SILHOUETTESCORE,Number=1,Type=Float,Description="silhouette score of genotype on this cnvr">
      ##INFO=<ID=CALINSKIHARABAZESCORE,Number=1,Type=Float,Description="calinski harabaz score of genotype on this cnvr">
      ##INFO=<ID=LOGLIKELIHOOD,Number=1,Type=Float,Description="log likelihood of genotype on this cnvr">
      #CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  ERR340328       ERR340329       ERR340330       ERR340331       ERR340333       ERR340334       ERR340335       ERR340336       ERR340338       ERR340340
      29      18501   29:18501-21000  A       CN0,CN2,CNH     .       .       END=21000;SVTYPE=DUP;SILHOUETTESCORE=0.3752531261841601;CALINSKIHARABAZESCORE=7525.499999999985;LOGLIKELIHOOD=3.4028975889394166        GT:CP   0/0:1.64        0/0:2.18        0/0:1.9 0/0:2.3 0/0:1.98        0/0:1.88        2/3:5.46        0/1:1.4 0/0:1.76        0/0:2.0
      29      31501   29:31501-35500  A       CN0,CN2 .       .       END=35500;SVTYPE=DUP;SILHOUETTESCORE=0.6403858269575723;CALINSKIHARABAZESCORE=1.0;LOGLIKELIHOOD=3.8248610888954095      GT:CP   0/1:1.5 0/2:3.06        0/0:2.02        0/0:1.96        0/0:1.78        0/0:2.02        0/2:3.18        0/0:2.22        0/0:1.98        0/0:2.08
      29      88501   29:88501-91000  A       CNH     .       .       END=91000;SVTYPE=DUP;SILHOUETTESCORE=0.8250872556146256;CALINSKIHARABAZESCORE=1.0;LOGLIKELIHOOD=3.8248610888954095      GT:CP   0/0:2.46        0/0:1.96        0/0:1.8 0/0:2.22        0/0:2.4 0/0:2.16        1/1:5.68        0/0:1.86        0/0:2.4 0/0:2.08
      29      274501  29:274501-277000        A       CN0     .       .       END=277000;SVTYPE=DEL;SILHOUETTESCORE=0.7361866027071716;CALINSKIHARABAZESCORE=1.0;LOGLIKELIHOOD=3.9634905250073986     GT:CP   0/0:1.84        0/1:1.22        0/1:1.22        0/1:1.0 0/1:1.0 0/1:0.9 0/1:1.1 0/1:1.14        0/1:1.18        0/1:1.2
      29      351501  29:351501-376500        A       CN2     .       .       END=376500;SVTYPE=DUP;SILHOUETTESCORE=0.7801860378062525;CALINSKIHARABAZESCORE=1.0;LOGLIKELIHOOD=3.963490525007399      GT:CP   0/0:1.84        0/1:3.24        0/0:1.96        0/0:1.92        0/1:2.94        0/0:2.1 1/1:4.12        0/0:1.96        0/0:1.98        0/0:1.98
      ```
