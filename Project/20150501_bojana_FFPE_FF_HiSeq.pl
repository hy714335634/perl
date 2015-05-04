#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;

my $task = "FFPE_FF_HiSeq";

my $target_dir = "/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq";

my $transcript_gtf       = "/scratch/cqs/shengq1/references/ensembl_gtf/v75/Homo_sapiens.GRCh37.75.M.gtf";
my $name_map_file        = "/scratch/cqs/shengq1/references/ensembl_gtf/v75/Homo_sapiens.GRCh37.75.M.map";
my $transcript_gtf_index = "/scratch/cqs/shengq1/references/ensembl_gtf/v75/gtfindex/Homo_sapiens.GRCh37.75.M";
my $fasta_file_16569_M   = "/scratch/cqs/shengq1/references/hg19_16569_M/hg19_16569_M.fa";
my $bowtie2_index        = "/scratch/cqs/shengq1/references/hg19_16569_M/bowtie2_index_2.2.4/hg19_16569_M";
my $cqstools             = "/home/shengq1/cqstools/CQS.Tools.exe";
my $dbsnp                = "/data/cqs/shengq1/reference/dbsnp/human_GRCh37_v141_16569_M.vcf";
my $gatk_jar             = "/home/shengq1/local/bin/GATK/GenomeAnalysisTK.jar";
my $picard_jar           = "/scratch/cqs/shengq1/local/bin/picard/picard.jar";
my $star_index           = "/scratch/cqs/shengq1/references/hg19_16569_M/STAR_index_v37.75_2.4.0j_sjdb100";
my $annovar_param        = "-protocol refGene,snp138,cosmic70 -operation g,f,f --remove";
my $annovar_db           = "/scratch/cqs/shengq1/references/annovar/humandb/";
my $rnaseqqc_jar         = "/scratch/cqs/shengq1/local/bin/RNA-SeQC_v1.1.8.jar";
my $rnaseqqc_gtf         = "/scratch/cqs/shengq1/references/ensembl_gtf/v75/Homo_sapiens.GRCh37.75.M.RNASeQC.gtf";

#minimum quality score 10, minimum overlap 4 bases, remove reads with length less than 30
my $cutadapt_option = "-q 10 -O 4 -m 30";

my $email = "quanhu.sheng\@vanderbilt.edu";

my $config = {
  general => { task_name => $task },
  files   => {
    "IG-064" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-10-2_ATGTCA_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-10-2_ATGTCA_L001_R2_001.fastq.gz"
    ],
    "IG-065" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-12-2_CATTTT_L003_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-12-2_CATTTT_L003_R2_001.fastq.gz"
    ],
    "IG-066" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-16-1_CGTACG_L007_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-16-1_CGTACG_L007_R2_001.fastq.gz"
    ],
    "IG-067" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-12-3_CGGAAT_L003_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-12-3_CGGAAT_L003_R2_001.fastq.gz"
    ],
    "IG-068" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-16-2_CACGAT_L007_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-16-2_CACGAT_L007_R2_001.fastq.gz"
    ],
    "IG-069" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-12-4_CTATAC_L003_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-12-4_CTATAC_L003_R2_001.fastq.gz"
    ],
    "IG-072" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-17-2_CTTGTA_L008_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-17-2_CTTGTA_L008_R2_001.fastq.gz"
    ],
    "IG-073" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-1_GTTTCG_L004_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-1_GTTTCG_L004_R2_001.fastq.gz"
    ],
    "IG-074" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-10-3_GTGGCC_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-10-3_GTGGCC_L001_R2_001.fastq.gz"
    ],
    "IG-075" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-2_CAAAAG_L004_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-2_CAAAAG_L004_R2_001.fastq.gz"
    ],
    "IG-076" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-10-4_GAGTGG_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-10-4_GAGTGG_L001_R2_001.fastq.gz"
    ],
    "IG-077" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-3_CACTCA_L004_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-3_CACTCA_L004_R2_001.fastq.gz"
    ],
    "IG-078" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-10-5_CACCGG_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-10-5_CACCGG_L001_R2_001.fastq.gz"
    ],
    "IG-079" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-4_CATGGC_L004_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-4_CATGGC_L004_R2_001.fastq.gz"
    ],
    "IG-080" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-17-3_GAGTGG_L008_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-17-3_GAGTGG_L008_R2_001.fastq.gz"
    ],
    "IG-081" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-5_CTCAGA_L004_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-13-5_CTCAGA_L004_R2_001.fastq.gz"
    ],
    "IG-086" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-11-1_CCGTCC_L002_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-11-1_CCGTCC_L002_R2_001.fastq.gz"
    ],
    "IG-087" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-14-3_CTAGCT_L005_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-14-3_CTAGCT_L005_R2_001.fastq.gz"
    ],
    "IG-088" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-11-2_GTAGAG_L002_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-11-2_GTAGAG_L002_R2_001.fastq.gz"
    ],
    "IG-089" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-14-4_TATAAT_L005_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-14-4_TATAAT_L005_R2_001.fastq.gz"
    ],
    "IG-090" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-11-3_GTGAAA_L002_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-11-3_GTGAAA_L002_R2_001.fastq.gz"
    ],
    "IG-091" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-14-5_TCGGCA_L005_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20150226_bojana_FFPE_FF/hiseq/rawdata/2059-JP-14-5_TCGGCA_L005_R2_001.fastq.gz"
    ],
  },
  groups => {
    "HiSeq_FF"   => [ "IG-064", "IG-066", "IG-068", "IG-072", "IG-074", "IG-076", "IG-078", "IG-080", "IG-086", "IG-088", "IG-090" ],
    "HiSeq_FFPE" => [ "IG-065", "IG-067", "IG-069", "IG-073", "IG-075", "IG-077", "IG-079", "IG-081", "IG-087", "IG-089", "IG-091" ],
  },
  pairs => {
    "HiSeq_FFPE_VS_FF" => {
      groups => [ "HiSeq_FF", "HiSeq_FFPE" ],
      paired => [ "P02",      "P03", "P04", "P06", "P07", "P08", "P09", "P10", "P13", "P14", "P15" ]
    },
  },
  fastqc => {
    class      => "QC::FastQC",
    perform    => 0,
    target_dir => "${target_dir}/fastqc",
    option     => "",
    source_ref => "files",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=2",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  cutadapt => {
    class      => "Cutadapt",
    perform    => 0,
    target_dir => "${target_dir}/cutadapt",
    option     => $cutadapt_option,
    source_ref => "files",
    adapter    => "AGATCGGAAGAG",
    extension  => "_clipped.fastq.gz",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "24",
      "mem"      => "20gb"
    },
  },
  fastqlen => {
    class      => "FastqLen",
    perform    => 0,
    target_dir => "${target_dir}/fastqlen",
    option     => "",
    source_ref => "cutadapt",
    cqstools   => $cqstools,
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "24",
      "mem"      => "20gb"
    },
  },
  star => {
    class      => "Alignment::STAR",
    perform    => 0,
    target_dir => "${target_dir}/star",
    option     => "",
    source_ref => "cutadapt",
    genome_dir => $star_index,
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },
  star_index => {
    class          => "Alignment::STARIndex",
    perform        => 0,
    target_dir     => "${target_dir}/star_index",
    option         => "--sjdbOverhang 75",
    source_ref     => [ "star", "tab\$" ],
    fasta_file     => $fasta_file_16569_M,
    transcript_gtf => $transcript_gtf,
    sh_direct      => 1,
    pbs            => {
      "email"    => $email,
      "nodes"    => "1:ppn=24",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },
  star_2nd_pass => {
    class           => "Alignment::STAR",
    perform         => 0,
    target_dir      => "${target_dir}/star_2nd_pass",
    option          => "",
    source_ref      => "cutadapt",
    genome_dir_ref  => "star_index",
    output_unsorted => 1,
    sh_direct       => 0,
    pbs             => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },
  star_2nd_pass_sort => {
    class         => "Samtools::Sort",
    perform       => 1,
    target_dir    => "${target_dir}/star_2nd_pass_sort",
    option        => "",
    source_ref    => ["star_2nd_pass", "_Aligned.out.bam" ],
    sort_by_query => 0,
    sh_direct     => 0,
    pbs           => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "20gb"
    },
  },
  rnaseqc => {
    class          => "QC::RNASeQC",
    perform        => 1,
    target_dir     => "${target_dir}/RNASeQC",
    option         => "",
    transcript_gtf => $rnaseqqc_gtf,
    fasta_file     => $fasta_file_16569_M,
    jar            => $rnaseqqc_jar,
    source_ref     => [ "star_2nd_pass_sort", "_Aligned.out.bam" ],
    pbs            => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  star_htseqcount => {
    class      => "Count::HTSeqCount",
    perform    => 0,
    target_dir => "${target_dir}/star_htseqcount",
    option     => "",
    source_ref => [ "star_2nd_pass", "_Aligned.out.bam" ],
    gff_file   => $transcript_gtf,
    ispairend  => 1,
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  star_genetable => {
    class         => "CQS::CQSDatatable",
    perform       => 1,
    target_dir    => "${target_dir}/star_genetable",
    option        => "-p ENS --noheader -o ${task}_gene.count",
    source_ref    => "star_htseqcount",
    name_map_file => $name_map_file,
    cqs_tools     => $cqstools,
    sh_direct     => 1,
    pbs           => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "10",
      "mem"      => "10gb"
    },
  },
  star_deseq2 => {
    class                => "Comparison::DESeq2",
    perform              => 0,
    target_dir           => "${target_dir}/star_deseq2",
    option               => "",
    source_ref           => "pairs",
    groups_ref           => "groups",
    countfile_ref        => "star_genetable",
    sh_direct            => 1,
    show_DE_gene_cluster => 1,
    pvalue               => 0.05,
    fold_change          => 2.0,
    pbs                  => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "10",
      "mem"      => "10gb"
    },
  },
  star_deseq2_strict_criteria => {
    class                => "Comparison::DESeq2",
    perform              => 0,
    target_dir           => "${target_dir}/star_deseq2_strict_criteria",
    option               => "",
    source_ref           => "pairs",
    groups_ref           => "groups",
    countfile_ref        => "star_genetable",
    sh_direct            => 1,
    show_DE_gene_cluster => 1,
    pvalue               => 0.01,
    fold_change          => 2.0,
    pbs                  => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "10",
      "mem"      => "10gb"
    },
  },
  star_2nd_pass_refine => {
    class      => "GATK::RNASeqRefine",
    perform    => 0,
    target_dir => "${target_dir}/star_2nd_pass_refine",
    option     => "-Xmx40g",
    fasta_file => $fasta_file_16569_M,
    source_ref => "star_2nd_pass",
    vcf_files  => [$dbsnp],
    gatk_jar   => $gatk_jar,
    picard_jar => $picard_jar,
    sorted     => 0,
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  star_2nd_pass_refine_SNPindel => {
    class       => "GATK::SNPIndel",
    perform     => 0,
    target_dir  => "${target_dir}/star_2nd_pass_refine_SNPindel",
    option      => "",
    source_ref  => "star_2nd_pass_refine",
    java_option => "",
    fasta_file  => $fasta_file_16569_M,
    dbsnp_vcf   => $dbsnp,
    gatk_jar    => $gatk_jar,
    is_rna      => 1,
    pbs         => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  star_2nd_pass_refine_SNPindel_annovar => {
    class      => "Annovar",
    perform    => 0,
    target_dir => "${target_dir}/star_2nd_pass_refine_SNPindel_annovar",
    source_ref => "star_2nd_pass_refine_SNPindel",
    option     => $annovar_param,
    annovar_db => $annovar_db,
    buildver   => "hg19",
    sh_direct  => 1,
    isvcf      => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "10gb"
    },
  },
  sequencetask => {
    class      => "CQS::SequenceTask",
    perform    => 0,
    target_dir => "${target_dir}/sequencetask",
    option     => "",
    source     => {
      step_1 => [ "cutadapt", "fastqlen", "fastqc", "star" ],
      step_2 => ["star_index"],
      step_3 => [ "star_2nd_pass", "star_htseqcount", "star_2nd_pass_refine" ],
      step_4 => [ "star_genetable", ],
      step_5 => [ "star_2nd_pass_refine_SNPindel", "star_2nd_pass_refine_SNPindel_annovar" ],
      step_6 => [ "star_deseq2",                   "star_deseq2_strict_criteria" ]
    },
    sh_direct => 1,
    pbs       => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
};

performConfig($config);

#performTask( $config, "star_deseq2" );
#performTask( $config, "star_deseq2_strict_criteria" );

#performTask( $config, "tophat2_genetable" );

1;
