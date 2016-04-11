#!/usr/bin/perl
use strict;
use warnings;

use CQS::FileUtils;
use CQS::ClassFactory;
use Hash::Merge qw( merge );

my $target_dir = create_directory_or_die("/scratch/cqs/shengq1/rnaseq/20160411_guoyan_rnaseqkit_callable_site");

#my $target_dir = create_directory_or_die("E:/temp");

my $email             = "quanhu.sheng\@vanderbilt.edu";
my $cqstools          = "/home/shengq1/cqstools/CQS.Tools.exe";

my $preparation = {
  general => { task_name => "preparation" },

  depth => {
    class         => "Samtools::DepthStat",
    perform       => 1,
    target_dir    => "${target_dir}/depth_stat",
    option        => "",
    minimum_depth => 20,
    source        => {
      "EAAIRABPEI-08"  => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAIRABPEI-8_sorted.bam"],
      "EAAJRABPEI-09"  => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAJRABPEI-9_sorted.bam"],
      "EAAKRABPEI-11"  => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAKRABPEI-11_sorted.bam"],
      "EAALRABPEI-12"  => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAALRABPEI-12_sorted.bam"],
      "EAAMRABPEI-13"  => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAMRABPEI-13_sorted.bam"],
      "EAANRABPEI-14"  => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAANRABPEI-14_sorted.bam"],
      "EAAORABPEI-15"  => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAORABPEI-15_sorted.bam"],
      "EAAPRABPEI-16"  => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAPRABPEI-16_sorted.bam"],
      "EAAARABPEI-201" => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAARABPEI-201_sorted.bam"],
      "EAABRABPEI-202" => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAABRABPEI-202_sorted.bam"],
      "EAACRABPEI-203" => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAACRABPEI-203_sorted.bam"],
      "EAADRABPEI-205" => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAADRABPEI-205_sorted.bam"],
      "EAAERABPEI-206" => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAERABPEI-206_sorted.bam"],
      "EAAFRABPEI-207" => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAFRABPEI-207_sorted.bam"],
      "EAAGRABPEI-208" => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAGRABPEI-208_sorted.bam"],
      "EAAHRABPEI-209" => ["/gpfs21/scratch/cqs/guom1/BGI_yan/tophat_G/tpG_bam/EAAHRABPEI-209_sorted.bam"],
    },
    cqstools  => $cqstools,
    sh_direct => 0,
    pbs       => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
};

performConfig($preparation);

1;

