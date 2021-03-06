#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;

my $task = "P3582";

my $target_dir = create_directory_or_die("/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq");

#my $target_dir = "e:/temp";

my $transcript_gtf = "/scratch/cqs/shengq1/references/gencode/hg19/gencode.v23lift37.annotation.gtf";
my $name_map_file  = "/scratch/cqs/shengq1/references/gencode/hg19/gencode.v23lift37.annotation.map";
my $star_index     = "/scratch/cqs/shengq1/references/gencode/hg19/STAR_index_2.5.2a";
my $fasta_file     = "/scratch/cqs/shengq1/references/gencode/hg19/STAR_index_2.5.2a/GRCh37.p13.genome.fa";

my $cqstools = "/home/shengq1/cqstools/cqstools.exe";
my $email    = "quanhu.sheng\@vanderbilt.edu";

my $config = {
  general => { task_name => $task },
  files   => {
    "A375_Melanoma_Pos" => [
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-1_S62_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-1_S62_R2_001.fastq.gz"
    ],
    "A375_Melanoma_Neg" => [
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-2_S63_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-2_S63_R2_001.fastq.gz"
    ],
    "SKMEL28_Melanoma_Pos" => [
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-3_S64_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-3_S64_R2_001.fastq.gz"
    ],
    "SKMEL28_Melanoma_Neg" => [
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-4_S65_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-4_S65_R2_001.fastq.gz"
    ],
    "HCC70_Breast_Pos" => [
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-5_S66_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-5_S66_R2_001.fastq.gz"
    ],
    "HCC70_Breast_Neg" => [
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-6_S67_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-6_S67_R2_001.fastq.gz"
    ],
    "MDA231_Breast_Pos" => [
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-7_S68_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-7_S68_R2_001.fastq.gz"
    ],
    "MDA231_Breast_Neg" => [
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-8_S69_R1_001.fastq.gz",
      "/gpfs21/scratch/cqs/shengq1/balko/20160926_human_celllines_rnaseq/data/3582-JMB-8_S69_R2_001.fastq.gz"
    ],
  },
  groups => {
    "MHCII_Pos" => [ "A375_Melanoma_Pos", "SKMEL28_Melanoma_Pos", "HCC70_Breast_Pos", "MDA231_Breast_Pos" ],
    "MHCII_Neg" => [ "A375_Melanoma_Neg", "SKMEL28_Melanoma_Neg", "HCC70_Breast_Neg", "MDA231_Breast_Neg" ],
  },
  pairs => {
    "MHCII_Pos_vs_Neg" => {
      groups   => [ "MHCII_Neg", "MHCII_Pos" ],
      Paired => [ "A375",      "SKMEL28", "HCC70", "MDA231", "A375", "SKMEL28", "HCC70", "MDA231" ],
      #Tumor    => [ "Melanoma",  "Melanoma", "Breast", "Breast", "Melanoma", "Melanoma", "Breast", "Breast" ]
    }
  },
  fastqc => {
    class      => "QC::FastQC",
    perform    => 1,
    target_dir => "${target_dir}/fastqc",
    option     => "",
    source_ref => "files",
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=2",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  fastqc_summary => {
    class      => "QC::FastQCSummary",
    perform    => 1,
    target_dir => "${target_dir}/fastqc",
    option     => "",
    source_ref => "fastqc",
    cqstools   => $cqstools,
    sh_direct  => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  star => {
    class                     => "Alignment::STAR",
    perform                   => 1,
    target_dir                => "${target_dir}/star",
    option                    => "--twopassMode Basic",
    source_ref                => "files",
    genome_dir                => $star_index,
    output_sort_by_coordinate => 1,
    sh_direct                 => 0,
    pbs                       => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },
  star_featurecount => {
    class      => "Count::FeatureCounts",
    perform    => 1,
    target_dir => "${target_dir}/star_featurecount",
    option     => "-g gene_id -t exon -M",
    source_ref => [ "star", "_Aligned.sortedByCoord.out.bam" ],
    gff_file   => $transcript_gtf,
    ispairend  => 1,
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  star_genetable => {
    class         => "CQS::CQSDatatable",
    perform       => 1,
    target_dir    => "${target_dir}/star_genetable",
    option        => "-k 0 -v 6 -e -o ${task}_gene.count",
    source_ref    => "star_featurecount",
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
  star_genetable_deseq2 => {
    class                => "Comparison::DESeq2",
    perform              => 1,
    target_dir           => "${target_dir}/star_genetable_deseq2",
    option               => "",
    source_ref           => "pairs",
    groups_ref           => "groups",
    countfile_ref        => "star_genetable",
    sh_direct            => 1,
    show_DE_gene_cluster => 0,
    pvalue               => 0.05,
    fold_change          => 2.0,
    min_median_read      => 5,
    add_count_one        => 0,
    pbs                  => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "10",
      "mem"      => "10gb"
    },
  },
  star_genetable_correlation => {
    class                    => "CQS::UniqueR",
    perform                  => 1,
    target_dir               => "${target_dir}/star_genetable_correlation",
    rtemplate                => "countTableVisFunctions.R,countTableGroupCorrelation.R",
    output_file              => "parameterSampleFile1",
    output_file_ext          => ".Correlation.png",
    parameterSampleFile1_ref => [ "star_genetable", ".count\$" ],
    parameterSampleFile2_ref => "groups",
    sh_direct                => 1,
    pbs                      => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "1",
      "mem"      => "10gb"
    },
  },

  sequencetask => {
    class      => "CQS::SequenceTask",
    perform    => 1,
    target_dir => "${target_dir}/sequencetask",
    option     => "",
    source     => {
      step1 => [ "fastqc",         "star",           "star_featurecount" ],
      step2 => [ "fastqc_summary", "star_genetable", "star_genetable_correlation", "star_genetable_deseq2" ],
    },
    sh_direct => 0,
    pbs       => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
};

performConfig($config);
1;

