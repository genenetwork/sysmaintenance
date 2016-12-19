This file explains how to convert the BXD genofile (BXD.geno) from mm9 to mm10 using Lift genome annotations at http://genome.ucsc.edu/cgi-bin/hgLiftOver.

---

- First, prepare a BED file for the mm9 positions that contains the **chromosome**, **start**, **end**, and **Id** of each marker. The **Id** column is necessary to keep track of the position, because the liftover tool will delete entries without a corresponding mm10 location.

- Next, replace the old Mb values (mm9) with the new ones (mm10). The results should look like the following:

   Chr | Start | End | Id
   ----- | ----- | ----- | -----
   chr1 | 3482275 | 3482375 | p1
   chr1 | 4811062 | 4811162 | p2
   chr1 | 5008089 | 5008189 | p3
   chr1 | 5176058 | 5176158 | p4
   chr1 | 5579193 | 5579293 | p5
   chr1 | 6217921 | 6218021 | p6
   chr1 | 6820241 | 6820341 | p7
   chr1 | 9995925 | 9996025 | p8
