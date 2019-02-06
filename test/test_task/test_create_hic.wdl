import "../../workflow/main_workflow/hic.wdl" as hic

workflow test_create_hic {
	File pairs_file
    File chrsz_
     
	call hic.create_hic as test_create_hic_task { input:
		pairs_file = pairs_file,
    	chrsz_ = chrsz_
    }
    File hic_file = test_create_hic_task.inter_30
    call strip_header { input:
        hic_file = hic_file
    }
    output {
        File no_header = strip_header.no_header
    }
}

task strip_header {
    File hic_file
    command {
        # header_size=1000
        hic_file=${hic_file}
        # file_length=$(wc -c < $hic_file)
        # num_bytes_to_keep=$((file_length - header_size))
        num_bytes_to_keep=301558
        tail -c $num_bytes_to_keep $hic_file > no_header.hic
    }
    output {
        File no_header = glob("no_header.hic")[0]
    }
    runtime {
        docker : "quay.io/encode-dcc/hic-pipeline:template"
    }
}
