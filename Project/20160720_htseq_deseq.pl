#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;

my $name_map_file = "/scratch/pingj1/db/hg38/gencode.v24.primary_assembly.annotation.map";
my $cqstools      = "/home/shengq1/cqstools/CQS.Tools.exe";

my $task       = "deseq";
my $target_dir = create_directory_or_die("/scratch/cqs/shengq1/rnaseq/20160720_htseq_deseq");
my $email      = "quanhu.sheng\@vanderbilt.edu";

my $config = {
  general => {
    task_name => $task,
  },
  files => {
    "DKO-1_Cell_1"         => ["/dors/bioinfo/exrna/RJC3839mRNA_Jie/htseqcount/old/3839_RJC_0001b.new.txt"],
    "DKO-1_Cell_2"         => ["/dors/bioinfo/exrna/RJC3839mRNA_Jie/htseqcount/old/3839_RJC_0002b.new.txt"],
    "DKO-1_Cell_3"         => ["/dors/bioinfo/exrna/RJC3839mRNA_Jie/htseqcount/old/3839_RJC_0003b.new.txt"],
    "DKO-1_Cell_4"         => ["/dors/bioinfo/exrna/RJC3839mRNA_Jie/htseqcount/old/3839_RJC_0004b.new.txt"],
    "DKO-1_Microvesicle_1" => ["/dors/bioinfo/exrna/RJC3839mRNA_Jie/htseqcount/old/3839_RJC_0005b.new.txt"],
    "DKO-1_Microvesicle_2" => ["/dors/bioinfo/exrna/RJC3839mRNA_Jie/htseqcount/old/3839_RJC_0006b.new.txt"],
    "DKO-1_Microvesicle_3" => ["/dors/bioinfo/exrna/RJC3839mRNA_Jie/htseqcount/old/3839_RJC_0007b.new.txt"],
    "DKO-1_Microvesicle_4" => ["/dors/bioinfo/exrna/RJC3839mRNA_Jie/htseqcount/old/3839_RJC_0008b.new.txt"],
  },

  groups => {
    "DKO-1_Cell"         => [ "DKO-1_Cell_1",         "DKO-1_Cell_2",         "DKO-1_Cell_3",         "DKO-1_Cell_4" ],
    "DKO-1_Microvesicle" => [ "DKO-1_Microvesicle_1", "DKO-1_Microvesicle_2", "DKO-1_Microvesicle_3", "DKO-1_Microvesicle_4" ],
  },
  pairs => {
    "MV_CELL" => { groups => [ "DKO-1_Cell", "DKO-1_Microvesicle" ], },
  },
  star_genetable => {
    class         => "CQS::CQSDatatable",
    perform       => 1,
    target_dir    => "${target_dir}/star_genetable",
    option        => "-p ENS --noheader -e -o ${task}_gene.count",
    source_ref    => "files",
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
    perform              => 1,
    target_dir           => "${target_dir}/star_deseq2",
    option               => "",
    source_ref           => "pairs",
    groups_ref           => "groups",
    countfile_ref        => "star_genetable",
    sh_direct            => 1,
    show_DE_gene_cluster => 1,
    pvalue               => 0.05,
    fold_change          => 2.0,
    min_median_read      => 5,
    pbs                  => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "10",
      "mem"      => "10gb"
    },
  },
};

performConfig($config);

1;
