#!/usr/bin/perl
use strict;
use warnings;

use CQS::PerformSmallRNA;

my $def = {

  #General options
  task_name  => "20150518_tRNA",
  email      => "quanhu.sheng\@vanderbilt.edu",
  target_dir => "/scratch/cqs/shengq1/vickers/20150518_tRNA_human",
  max_thread => 8,

  #Default software parameter (don't change it except you really know it)
  fastq_remove_N => 0,
  adapter        => "AGATCGGAAGAG",

  #Data
  files => {
    "KCVH01" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH1_S6_R1_001.fastq.gz"],
    "KCVH02" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH2_S8_R1_001.fastq.gz"],
    "KCVH03" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH3_S9_R1_001.fastq.gz"],
    "KCVH04" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH4_S10_R1_001.fastq.gz"],
    "KCVH05" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH5_S11_R1_001.fastq.gz"],
    "KCVH06" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH6_S12_R1_001.fastq.gz"],
    "KCVH07" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH7_S13_R1_001.fastq.gz"],
    "KCVH08" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH8_S14_R1_001.fastq.gz"],
    "KCVH09" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH9_S15_R1_001.fastq.gz"],
    "KCVH10" => ["/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH10_S7_R1_001.fastq.gz"],
  }
};

performSmallRNA_hg19($def);

1;

