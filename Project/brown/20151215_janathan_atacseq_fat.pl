#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;
use Data::Dumper;

my $target_dir = create_directory_or_die("/scratch/cqs/shengq1/atacseq/20151215_janathan_atacseq_fat");

my $email = "quanhu.sheng\@vanderbilt.edu";
my $task  = "fat";

my $macs2call_option = "-f BED -g mm -B -q 0.01 --nomodel";

my $config = {
  general => { task_name => $task },
  files   => {
    "SQ1_CHOW"   => ["/gpfs21/scratch/cqs/shengq1/atacseq/data/fat/20150911_4895_mm9.noChrM.fix.rmdup.sorted.bam"],
    "SQ2_CHOW"   => ["/gpfs21/scratch/cqs/shengq1/atacseq/data/fat/20150911_4896_mm9.noChrM.fix.rmdup.sorted.bam"],
    "Visc1_CHOW" => ["/gpfs21/scratch/cqs/shengq1/atacseq/data/fat/20150911_4897_mm9.noChrM.fix.rmdup.sorted.bam"],
    "Visc2_CHOW" => ["/gpfs21/scratch/cqs/shengq1/atacseq/data/fat/20150911_4898_mm9.noChrM.fix.rmdup.sorted.bam"],
    "SQ1_HFD"    => ["/gpfs21/scratch/cqs/shengq1/atacseq/data/fat/20150911_4899_mm9.noChrM.fix.rmdup.sorted.bam"],
    "SQ2_HFD"    => ["/gpfs21/scratch/cqs/shengq1/atacseq/data/fat/20150911_4900_mm9.noChrM.fix.rmdup.sorted.bam"],
    "Visc1_HFD"  => ["/gpfs21/scratch/cqs/shengq1/atacseq/data/fat/20150911_4901_mm9.noChrM.fix.rmdup.sorted.bam"],
    "Visc2_HFD"  => ["/gpfs21/scratch/cqs/shengq1/atacseq/data/fat/20150911_4902_mm9.noChrM.fix.rmdup.sorted.bam"],
  },
  replicates => {
    "SQ_CHOW"   => [ "SQ1_CHOW",   "SQ2_CHOW" ],
    "Visc_CHOW" => [ "Visc1_CHOW", "Visc2_CHOW" ],
    "SQ_HFD"    => [ "SQ1_HFD",    "SQ2_HFD" ],
    "Visc_HFD"  => [ "Visc1_HFD",  "Visc2_HFD" ],
  },
  replicates_comparison => {
    "SQ_Visc_CHOW" => [ "SQ_CHOW", "Visc_CHOW" ],
    "SQ_Visc_HFD"  => [ "SQ_HFD",  "Visc_HFD" ],
  },
  individual_comparison => {
    "SQ1_Visc1_CHOW" => [ "SQ1_CHOW", "Visc1_CHOW" ],
    "SQ2_Visc2_CHOW" => [ "SQ2_CHOW", "Visc2_CHOW" ],
    "SQ1_Visc1_HFD"  => [ "SQ1_HFD",  "Visc1_HFD" ],
    "SQ2_Visc2_HFD"  => [ "SQ2_HFD",  "Visc2_HFD" ],
    "SQ1_Visc2_CHOW" => [ "SQ1_CHOW", "Visc2_CHOW" ],
    "SQ2_Visc1_CHOW" => [ "SQ2_CHOW", "Visc1_CHOW" ],
    "SQ1_Visc2_HFD"  => [ "SQ1_HFD",  "Visc2_HFD" ],
    "SQ2_Visc1_HFD"  => [ "SQ2_HFD",  "Visc1_HFD" ],
  },
  replicates_group => {
    "SQ_Visc_CHOW" => [ "SQ1_CHOW", "SQ2_CHOW", "Visc1_CHOW", "Visc2_CHOW" ],
    "SQ_Visc_HFD"  => [ "SQ1_HFD",  "SQ2_HFD",  "Visc1_HFD",  "Visc2_HFD" ],
  },
  bam2bed => {
    class          => "ATACseq::BamToBed",
    perform        => 1,
    target_dir     => "${target_dir}/bam2bed",
    option         => "",
    source_ref     => "files",
    blacklist_file => "/scratch/cqs/shengq1/references/mappable_region/mm9/mm9-blacklist.bed",
    sh_direct      => 0,
    pbs            => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  macs2callpeak_individual_nomodel => {
    class      => "Chipseq::MACS2Callpeak",
    perform    => 1,
    target_dir => "${target_dir}/macs2callpeak_individual_nomodel",
    option     => $macs2call_option,
    source_ref => "bam2bed",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  macs2bdgdiff_individual_nomodel => {
    class      => "Chipseq::MACS2Bdgdiff",
    perform    => 1,
    target_dir => "${target_dir}/macs2bdgdiff_individual_nomodel",
    option     => "",
    source_ref => "macs2callpeak_individual_nomodel",
    groups_ref => "individual_comparison",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  macs2callpeak_replicates_nomodel => {
    class      => "Chipseq::MACS2Callpeak",
    perform    => 1,
    target_dir => "${target_dir}/macs2callpeak_replicates_nomodel",
    option     => $macs2call_option,
    source_ref => "bam2bed",
    groups_ref => "replicates",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  macs2bdgdiff_replicates_nomodel => {
    class      => "Chipseq::MACS2Bdgdiff",
    perform    => 1,
    target_dir => "${target_dir}/macs2bdgdiff_replicates_nomodel",
    option     => "",
    source_ref => "macs2callpeak_replicates_nomodel",
    groups_ref => "replicates_comparison",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  macs2bdgdiff_replicates_nomodel_depth => {
    class         => "Visualization::Depth",
    perform       => 1,
    target_dir    => "${target_dir}/macs2bdgdiff_replicates_nomodel_depth",
    option        => "",
    source_ref    => "macs2bdgdiff_replicates_nomodel",
    groups_ref    => "replicates_group",
    bam_files_ref => "files",
    sh_direct     => 0,
    pbs           => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  sequencetask => {
    class      => "CQS::SequenceTask",
    perform    => 1,
    target_dir => "${target_dir}/sequencetask",
    option     => "",
    source     => {
      "step1" => [ "bam2bed", "macs2callpeak_individual_nomodel" ],
      "step2" => ["macs2bdgdiff_individual_nomodel"],
    },
    sh_direct => 0,
    pbs       => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  }
};

#performConfig($config);
performTask( $config, "sequencetask" );

1;
