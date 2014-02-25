#!/usr/bin/perl
use strict;
use warnings;

use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ClassFactory;
use CQS::CNV;

my $target_dir = create_directory_or_die("/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton");

my $fasta_file = "/data/cqs/guoy1/reference/hg19/bwa_index_0.7.4/hg19_chr.fa";
my $dbsnp      = "/data/cqs/shengq1/reference/snp137/human/00-All.vcf";
my $gatk       = "/home/shengq1/local/bin/GATK/GenomeAnalysisTK.jar";
my $picard_dir = "/home/shengq1/local/bin/picard/";

my $email = "quanhu.sheng\@vanderbilt.edu";

my $config = {
  general    => { task_name => "chipseq_clayton" },
  fastqfiles => {
    "1806-p73IP_S1" => [
      "/gpfs21/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton/data/analysis_5011011/1806-p73IP_S1_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton/data/analysis_5011011/1806-p73IP_S1_L001_R2_001.fastq.gz"
    ],
    "1806-p63IP_S2" => [
      "/gpfs21/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton/data/analysis_5011011/1806-p63IP_S2_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton/data/analysis_5011011/1806-p63IP_S2_L001_R2_001.fastq.gz"
    ],
    "2653-JP-34_S1" => [
      "/gpfs21/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton/data/analysis_5049046/2653-JP-34_S1_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton/data/analysis_5049046/2653-JP-34_S1_L001_R2_001.fastq.gz"
    ],
    "2653-JP-35_S2" => [
      "/gpfs21/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton/data/analysis_5049046/2653-JP-35_S2_L001_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/chipseq/20140224_jennifer_chipseq_clayton/data/analysis_5049046/2653-JP-35_S2_L001_R2_001.fastq.gz"
    ],
  },
  fastqc => {
    class      => "FastQC",
    perform    => 0,
    target_dir => "${target_dir}/fastqc",
    option     => "",
    source_ref => "fastqfiles",
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  bwa => {
    class      => "BWA",
    perform    => 0,
    target_dir => "${target_dir}/bwa",
    option     => "-t 8",
    fasta_file => $fasta_file,
    source_ref => "fastqfiles",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  scythe => {
    class        => "Trimmer::Scythe",
    perform      => 1,
    target_dir   => "${target_dir}/scythe",
    option       => "-n 10 -M 30",
    source_ref   => "fastqfiles",
    adapter_file => "/scratch/cqs/shengq1/local/bin/illumina_adapters.fa",
    extension    => "_clipped.fastq",
    sh_direct    => 1,
    pbs          => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "24",
      "mem"      => "20gb"
    },
  },
  bwa_scythe => {
    class      => "BWA",
    perform    => 1,
    target_dir => "${target_dir}/bwa_scythe",
    option     => "-t 8",
    fasta_file => $fasta_file,
    source_ref => "scythe",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  refine => {
    class              => "GATKRefine",
    perform            => 1,
    target_dir         => "${target_dir}/refine",
    option             => "-Xmx40g",
    fasta_file         => $fasta_file,
    source_ref         => "bwa_scythe",
    thread_count       => 8,
    vcf_files          => [$dbsnp],
    gatk_jar           => $gatk,
    markDuplicates_jar => "${picard_dir}/MarkDuplicates.jar",
    sh_direct          => 0,
    pbs                => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  overall => {
    class      => "CQS::SequenceTask",
    perform    => 1,
    target_dir => "${target_dir}/overall",
    option     => "",
    source     => { individual => [ "fastqc", "bwa", "scythe", "bwa_scythe", "refine" ] },
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
};

performConfig($config);

1;