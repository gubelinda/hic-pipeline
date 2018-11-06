import "../../hic.wdl" as hic

workflow test_bam2pairs {
	File bam 		    # bam file to convert into pairs
    File chrsz          # chromosome sizes file

	call hic.bam2pairs as test { input:
	    bam_file = bam,
    	chrsz_ = chrsz
	}

 	output {
        File pairs = test.out_file
    } 
}