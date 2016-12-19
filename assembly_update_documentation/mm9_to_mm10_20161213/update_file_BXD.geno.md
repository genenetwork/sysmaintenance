BXD.geno was updated to mm10. using Lift genome annotations at
http://genome.ucsc.edu/cgi-bin/hgLiftOver

First, I prepared a BED file with the (mm9 positions) chromosome, start, end, Id (Id column is important to keep track of the position since genome liftover delete the row not found. 

Then replace the old Mb values (mm9) with the new ones (mm10)

chr1	3482275	3482375	p1
chr1	4811062	4811162	p2
chr1	5008089	5008189	p3
chr1	5176058	5176158	p4
chr1	5579193	5579293	p5
chr1	6217921	6218021	p6
chr1	6820241	6820341	p7
chr1	9995925	9996025	p8
