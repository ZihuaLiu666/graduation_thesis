# graduation thesis

### STEP 1: Principle Component Analysis
* convert snp table file to .geno, .ind and .snp files (perl script `VCFtable2eigen_geno_snp_ind.pl` needed, which is in the scripts subdirectory)

      perl VCFtable2eigen_geno_snp_ind.pl <table file> <name.geno> <name.snp> <name.ind>

  For example, `4year.snp.results.table.chr1` is my input <table file> and the three output files are `4year.snp.chr1.geno`, `4year.snp.chr1.ind` and `4year.snp.chr1.snp`.
  
  At the end of the step, three files are constructed: `<name.geno>` `<name.snp>` `<name.ind>`

* `smartpca.perl` script (in the scripts subdirectory) AND `name.geno`, `name.ind` and `name.snp` are used for final PCA

      perl smartpca.perl -i <name.geno> -a <name.snp> -b <name.ind> -k 5 -m 0 -o <name.pca> -p <name.plot> -e <name.eval> -l <name.log>
      
  At the end of the step, five files are built: `<name.eval>` `<name.log>` `<name.pca>` `<name.pca.evec>` `<name.pca.par>`

* Plot PC1-PC2 or PC1-PC3 figures by MATLAB

I wrote a .m function, plot_PCA(m,n,y1,y2,X), in which m and n represents the dimension order, y1 and y2 are the year number (such as, y1 = 2005 and y2 = 2014) and X is the `<name.pca.evec>` with removed first row, first column and the last column.

**NOTICE**: Actually, you can unify the **<name>** as prefix, such as 4year.snp.chr1 

I wrote a .m function, plot_PCA(m,n,y1,y2,X), in which m and n represents the dimension order, y1 and y2 are the year number (such as, y1 = 2005 and y2 = 2014) and X is the `<name.pca.evec>` with removed first row, first column and the last column.
