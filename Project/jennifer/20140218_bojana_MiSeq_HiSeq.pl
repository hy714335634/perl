#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;

my $task = "20140218_bojana_MiSeq_HiSeq";

my $target_dir;

if ( is_linux() ) {
  $target_dir = create_directory_or_die("/scratch/cqs/shengq1/rnaseq/${task}_v5");
}
else {
  $target_dir = "h:/temp";
}

my $fasta_file           = "/data/cqs/guoy1/reference/hg19/bwa_index_0.7.4/hg19_chr.fa";
my $transcript_gtf       = "/scratch/cqs/shengq1/references/hg19/Homo_sapiens.GRCh37.73.gtf";
my $transcript_gtf_index = "/scratch/cqs/shengq1/gtfindex/hg19_GRCh37_73";

my $hg19_gff = "/scratch/cqs/shengq1/references/hg19/dexseq_gff/Homo_sapiens.GRCh37.73.dexseq.gff";
my $hg19_map = "/scratch/cqs/shengq1/references/hg19/Homo_sapiens.GRCh37.73.map";

my $bowtie2_index = "/data/cqs/guoy1/reference/hg19/bowtie2_index/hg19";

my $cqstools = "/home/shengq1/cqstools/CQS.Tools.exe";

my $email = "quanhu.sheng\@vanderbilt.edu";

my $config = {
  general    => { task_name => $task },
  MiSeqfiles => {
    "MiSeqSample1" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20140218_bojana_MiSeq_HiSeq/rawdata/IG-33_408637_S4_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20140218_bojana_MiSeq_HiSeq/rawdata/IG-33_408637_S4_L001_R2_001.fastq.gz"
    ],
    "MiSeqSample2" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20140218_bojana_MiSeq_HiSeq/rawdata/IG-34_S3_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20140218_bojana_MiSeq_HiSeq/rawdata/IG-34_S3_L001_R2_001.fastq.gz"
    ],
    "MiSeqSample3" => [
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20140218_bojana_MiSeq_HiSeq/rawdata/IG-39_408648_S5_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/rnaseq/20140218_bojana_MiSeq_HiSeq/rawdata/IG-39_408648_S5_L001_R2_001.fastq.gz"
    ],
  },
  HiSeqfiles => {
    "HiSeqSample1" => [ "/autofs/blue_sequencer/Runs/projects/2059-JP/2013-07-24/2059-JP-6_1.fastq.gz", "/autofs/blue_sequencer/Runs/projects/2059-JP/2013-07-24/2059-JP-6_2.fastq.gz" ],
    "HiSeqSample2" => [ "/autofs/blue_sequencer/Runs/projects/2059-JP/2013-07-24/2059-JP-7_1.fastq.gz", "/autofs/blue_sequencer/Runs/projects/2059-JP/2013-07-24/2059-JP-7_2.fastq.gz" ],
    "HiSeqSample3" => [ "/autofs/blue_sequencer/Runs/projects/2059-JP/2013-07-24/2059-JP-9_1.fastq.gz", "/autofs/blue_sequencer/Runs/projects/2059-JP/2013-07-24/2059-JP-9_2.fastq.gz" ],
  },
  groups => {
    "MiSeq" => [ "MiSeqSample1", "MiSeqSample2", "MiSeqSample3" ],
    "HiSeq" => [ "HiSeqSample1", "HiSeqSample2", "HiSeqSample3" ],
  },
  pairs => {
    "HiSeq_vs_MiSeq" => {
      groups => [ "MiSeq", "HiSeq" ],
      paired => 1
    }
  },
  fastqc => {
    class      => "FastQC",
    perform    => 0,
    target_dir => "${target_dir}/fastqc",
    option     => "",
    source_ref => [ "MiSeqfiles", "HiSeqfiles" ],
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=2",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  trimmer => {
    class      => "CQS::FastqTrimmer",
    perform    => 0,
    target_dir => "${target_dir}/trimmer",
    option     => "-n -z",
    extension  => "_trim.fastq.gz",
    source_ref => "HiSeqfiles",
    cqstools   => $cqstools,
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  fastqc_trim => {
    class      => "FastQC",
    perform    => 0,
    target_dir => "${target_dir}/fastqc_trim",
    option     => "",
    source_ref => "trimmer",
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=2",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  tophat2 => {
    class                => "Tophat2",
    perform              => 0,
    target_dir           => "${target_dir}/tophat2",
    option               => "--segment-length 25 -r 0 -p 8",
    source_ref           => [ "MiSeqfiles", "trimmer" ],
    bowtie2_index        => $bowtie2_index,
    transcript_gtf       => $transcript_gtf,
    transcript_gtf_index => $transcript_gtf_index,
    rename_bam           => 1,
    sh_direct            => 0,
    pbs                  => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },
  rnaseqc => {
    class          => "RNASeQC",
    perform        => 0,
    target_dir     => "${target_dir}/RNASeQC",
    option         => "",
    transcript_gtf => $transcript_gtf,
    fasta_file     => $fasta_file,
    jar            => "/home/shengq1/local/bin/RNA-SeQC_v1.1.7.jar",
    source_ref     => "tophat2",
    pbs            => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  sortbam => {
    class         => "Sortbam",
    perform       => 0,
    target_dir    => "${target_dir}/sortname",
    option        => "",
    source_ref    => "tophat2",
    sort_by_query => 1,
    sh_direct     => 0,
    pbs           => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "20gb"
    },
  },
  htseqcount => {
    class      => "HTSeqCount",
    perform    => 0,
    target_dir => "${target_dir}/htseqcount",
    option     => "",
    source_ref => "sortbam",
    gff_file   => $transcript_gtf,
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  genetable => {
    class         => "CQSDatatable",
    perform       => 0,
    target_dir    => "${target_dir}/genetable",
    option        => "-p ENS --noheader -o ${task}_gene.count",
    source_ref    => "htseqcount",
    name_map_file => $hg19_map,
    cqs_tools     => $cqstools,
    sh_direct     => 1,
    pbs           => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "10",
      "mem"      => "10gb"
    },
  },
  deseq2 => {
    class         => "DESeq2",
    perform       => 0,
    target_dir    => "${target_dir}/deseq2",
    option        => "",
    source_ref    => "pairs",
    groups_ref    => "groups",
    countfile_ref => "genetable",
    sh_direct     => 1,
    pbs           => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "10",
      "mem"      => "10gb"
    },
  },
  cuffdiff => {
    class          => "Cuffdiff",
    perform        => 1,
    target_dir     => "${target_dir}/cuffdiff",
    option         => "-p 8 -u -N",
    transcript_gtf => $transcript_gtf,
    fasta_file     => $fasta_file,
    source_ref     => "tophat2",
    groups_ref     => "groups",
    pairs_ref      => "pairs",
    sh_direct      => 0,
    pbs            => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },
  sequence_task => {
    class      => "SequenceTask",
    perform    => 0,
    target_dir => "${target_dir}/overall",
    source     => {
      "gene" => [ "fastqc", "trimmer", "fastqc_trim", "tophat2", "sortbam", "htseqcount" ],
      "table" => [ "genetable", "deseq2", "cuffdiff", "rnaseqc" ],
    },
    sh_direct => 0,
    pbs       => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    }
  }
};

performConfig($config);

#performTask($config, "cuffdiff");

#my $pairs = $config->{"pairs" };
#my ( $ispaired, $gNames ) = get_pair_groups( $pairs, "HiSeq_vs_MiSeq" );

1;
