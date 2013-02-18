#!/usr/bin/perl
use strict;
use warnings;

use CQS::QC;
use CQS::RNASeq;
use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::Samtools;

my $target_dir = "/scratch/cqs/shengq1/somaticmutation";

my $email = "quanhu.sheng\@vanderbilt.edu";

my $config = {
  general => {
    path_file => "/home/shengq1/bin/path.txt",
    task_name => "mpileup"
  },
  bamfiles => {
    "TCGA-A7-A0D9" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-A7-A0D9/TCGA-A7-A0D9-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-A7-A0D9/TCGA-A7-A0D9-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0B3" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0B3/TCGA-BH-A0B3-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0B3/TCGA-BH-A0B3-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0B8" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0B8/TCGA-BH-A0B8-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0B8/TCGA-BH-A0B8-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0BJ" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0BJ/TCGA-BH-A0BJ-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0BJ/TCGA-BH-A0BJ-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0BM" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0BM/TCGA-BH-A0BM-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0BM/TCGA-BH-A0BM-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0C0" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0C0/TCGA-BH-A0C0-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0C0/TCGA-BH-A0C0-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0DK" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0DK/TCGA-BH-A0DK-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0DK/TCGA-BH-A0DK-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0DP" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0DP/TCGA-BH-A0DP-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0DP/TCGA-BH-A0DP-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0E0" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0E0/TCGA-BH-A0E0-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0E0/TCGA-BH-A0E0-RNA_NT_sorted.bam"
    ],
    "TCGA-BH-A0H7" => [
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0H7/TCGA-BH-A0H7-RNA_TP_sorted.bam",
      "/workspace/guoy1/GeneTorrent/lij17/processed/BRCA/TCGA-BH-A0H7/TCGA-BH-A0H7-RNA_NT_sorted.bam"
    ],
  },
  mpileup => {
    target_dir         => "${target_dir}/mpileup",
    option             => "-q 20 -Q 20 -r 1",
    source_ref         => "bamfiles",
    minimum_count      => 4,
    reference_sequence => "/data/cqs/guoy1/reference/hg19/bowtie2_index/hg19.fa",
    pbs                => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "10gb"
    },
  },
};

mpileup( $config, "mpileup" );

1;
