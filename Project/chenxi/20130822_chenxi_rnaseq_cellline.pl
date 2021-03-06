#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;

my $target_dir = create_directory_or_die("/scratch/cqs/shengq1/rnaseq/20130822_chenxi_rnaseq_cellline");

my $transcript_gtf       = "/data/cqs/guoy1/reference/annotation2/hg19/Homo_sapiens.GRCh37.68.gtf";
my $transcript_gtf_index = "/scratch/cqs/shengq1/gtfindex/hg19_GRCh37_68";

my $bowtie2_index = "/data/cqs/guoy1/reference/hg19/bowtie2_index/hg19";
my $fasta_file    = "/data/cqs/guoy1/reference/hg19/hg19_chr.fa";

my $email = "quanhu.sheng\@vanderbilt.edu";

my $config = {
  general    => { task_name => "2404" },
  fastqfiles => {
    "2404-NGD-001" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-1_1.fastq.gz"],
    "2404-NGD-009" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-9_1.fastq.gz"],
    "2404-NGD-010" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-10_1.fastq.gz"],
    "2404-NGD-011" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-11_1.fastq.gz"],
    "2404-NGD-012" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-12_1.fastq.gz"],
    "2404-NGD-025" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-01-22/2404-NGD-25_1.fastq.gz"],
    "2404-NGD-026" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-01-22/2404-NGD-26_1.fastq.gz"],
    "2404-NGD-027" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-01-22/2404-NGD-27_1.fastq.gz"],
    "2404-NGD-028" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-01-22/2404-NGD-28_1.fastq.gz"],
    "2404-NGD-029" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-01-22/2404-NGD-29_1.fastq.gz"],
    "2404-NGD-030" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-30_1.fastq.gz"],
    "2404-NGD-031" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-31_1.fastq.gz"],
    "2404-NGD-032" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-32_1.fastq.gz"],
    "2404-NGD-033" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-33_1.fastq.gz"],
    "2404-NGD-034" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-34_1.fastq.gz"],
    "2404-NGD-035" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-35_1.fastq.gz"],
    "2404-NGD-039" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-39_1.fastq.gz"],
    "2404-NGD-040" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-40_1.fastq.gz"],
    "2404-NGD-041" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-41_1.fastq.gz"],
    "2404-NGD-042" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-42_1.fastq.gz"],
    "2404-NGD-043" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-04-16/2404-NGD-43_1.fastq.gz"],
    "2404-NGD-045" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-45_1.fastq.gz"],
    "2404-NGD-046" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-46_1.fastq.gz"],
    "2404-NGD-047" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-47_1.fastq.gz"],
    "2404-NGD-048" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-48_1.fastq.gz"],
    "2404-NGD-049" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-49_1.fastq.gz"],
    "2404-NGD-051" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-51_1.fastq.gz"],
    "2404-NGD-052" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-52_1.fastq.gz"],
    "2404-NGD-053" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-53_1.fastq.gz"],
    "2404-NGD-054" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-54_1.fastq.gz"],
    "2404-NGD-055" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-55_1.fastq.gz"],
    "2404-NGD-056" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-56_1.fastq.gz"],
    "2404-NGD-057" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-57_1.fastq.gz"],
    "2404-NGD-059" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-05-17/2404-NGD-59_1.fastq.gz"],
    "2404-NGD-062" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-62_1.fastq.gz"],
    "2404-NGD-063" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-63_1.fastq.gz"],
    "2404-NGD-064" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-64_1.fastq.gz"],
    "2404-NGD-066" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-66_1.fastq.gz"],
    "2404-NGD-067" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-19/2404-NGD-67_1.fastq.gz"],
    "2404-NGD-068" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-19/2404-NGD-68_1.fastq.gz"],
    "2404-NGD-069" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-19/2404-NGD-69_1.fastq.gz"],
    "2404-NGD-070" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-19/2404-NGD-70_1.fastq.gz"],
    "2404-NGD-071" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-19/2404-NGD-71_1.fastq.gz"],
    "2404-NGD-072" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-19/2404-NGD-72_1.fastq.gz"],
    "2404-NGD-073" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-19/2404-NGD-73_1.fastq.gz"],
    "2404-NGD-074" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-74_1.fastq.gz"],
    "2404-NGD-075" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-75_1.fastq.gz"],
    "2404-NGD-077" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-77_1.fastq.gz"],
    "2404-NGD-078" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-78_1.fastq.gz"],
    "2404-NGD-079" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-79_1.fastq.gz"],
    "2404-NGD-080" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-80_1.fastq.gz"],
    "2404-NGD-081" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-81_1.fastq.gz"],
    "2404-NGD-090" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-90_1.fastq.gz"],
    "2404-NGD-091" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-91_1.fastq.gz"],
    "2404-NGD-092" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-92_1.fastq.gz"],
    "2404-NGD-093" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-93_1.fastq.gz"],
    "2404-NGD-095" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-95_1.fastq.gz"],
    "2404-NGD-096" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-96_1.fastq.gz"],
    "2404-NGD-097" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-97_1.fastq.gz"],
    "2404-NGD-098" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-98_1.fastq.gz"],
    "2404-NGD-099" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-99_1.fastq.gz"],
    "2404-NGD-100" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-100_1.fastq.gz"],
    "2404-NGD-101" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-101_1.fastq.gz"],
    "2404-NGD-102" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-102_1.fastq.gz"],
    "2404-NGD-104" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-104_1.fastq.gz"],
    "2404-NGD-106" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-106_1.fastq.gz"],
    "2404-NGD-110" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-110_1.fastq.gz"],
    "2404-NGD-111" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-111_1.fastq.gz"],
    "2404-NGD-112" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-112_1.fastq.gz"],
    "2404-NGD-113" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-113_1.fastq.gz"],
    "2404-NGD-116" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-116_1.fastq.gz"],
    "2404-NGD-117" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-117_1.fastq.gz"],
    "2404-NGD-118" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-118_1.fastq.gz"],
    "2404-NGD-119" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-06-22/2404-NGD-119_1.fastq.gz"],
    "2404-NGD-120" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-120_1.fastq.gz"],
    "2404-NGD-122" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-122_1.fastq.gz"],
    "2404-NGD-123" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-123_1.fastq.gz"],
    "2404-NGD-125" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-125_1.fastq.gz"],
    "2404-NGD-126" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-126_1.fastq.gz"],
    "2404-NGD-128" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-128_1.fastq.gz"],
    "2404-NGD-131" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-131_1.fastq.gz"],
    "2404-NGD-132" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-132_1.fastq.gz"],
    "2404-NGD-134" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-134_1.fastq.gz"],
    "2404-NGD-135" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-135_1.fastq.gz"],
    "2404-NGD-137" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-137_1.fastq.gz"],
    "2404-NGD-138" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-138_1.fastq.gz"],
    "2404-NGD-139" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-139_1.fastq.gz"],
    "2404-NGD-140" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-08-14/2404-NGD-140_1.fastq.gz"],
    "2404-NGD-141" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-141_1.fastq.gz"],
    "2404-NGD-147" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-147_1.fastq.gz"],
    "2404-NGD-148" => ["/autofs/blue_sequencer/Runs/projects/2404-NGD/2013-07-19/2404-NGD-148_1.fastq.gz"],
  },
  groups => {
    "HCT116_Plastic"           => [ "2404-NGD-039", "2404-NGD-040", "2404-NGD-041" ],
    "HCT116_Rectal"            => [ "2404-NGD-080", "2404-NGD-081", "2404-NGD-104", "2404-NGD-106" ],
    "HCT116_Horizon_Plastic"   => [ "2404-NGD-091", "2404-NGD-092", "2404-NGD-093" ],
    "HCT116_Kras_G13D_Plastic" => [ "2404-NGD-097", "2404-NGD-098", "2404-NGD-099" ],
    "HCT116_Kras_G13D_Rectal"  => [ "2404-NGD-134", "2404-NGD-135", "2404-NGD-138" ],
    "HCT116_Kras_Rectal"       => [ "2404-NGD-131", "2404-NGD-132", "2404-NGD-137" ],
    "DLD1_Plastic"             => [ "2404-NGD-048", "2404-NGD-049", "2404-NGD-073" ],
    "DLD1_Rectal"              => [ "2404-NGD-112", "2404-NGD-113", "2404-NGD-139" ],
    "DKO1_Plastic"             => [ "2404-NGD-057", "2404-NGD-075", "2404-NGD-100" ],
    "DKO1_Rectal"              => [ "2404-NGD-118", "2404-NGD-119", "2404-NGD-116", "2404-NGD-117" ],
    "DKS8_Plastic"             => [ "2404-NGD-054", "2404-NGD-055", "2404-NGD-056" ],
    "SW480_Plastic"            => [ "2404-NGD-001", "2404-NGD-034", "2404-NGD-035" ],
    "SW620_Plastic"            => [ "2404-NGD-009", "2404-NGD-010", "2404-NGD-011", "2404-NGD-012" ],
    "SW620_Rectal"             => [ "2404-NGD-025", "2404-NGD-026", "2404-NGD-027", "2404-NGD-028", "2404-NGD-029" ],
    "KM12C_Plastic"            => [ "2404-NGD-051", "2404-NGD-052", "2404-NGD-053" ],
    "KM12SM_Plastic"           => [ "2404-NGD-088", "2404-NGD-140", "2404-NGD-141" ],
    "KM12SM_Rectal"            => [ "2404-NGD-125", "2404-NGD-126", "2404-NGD-128" ],
    "Ls174T_Plastic"           => [ "2404-NGD-042", "2404-NGD-043", "2404-NGD-147" ],
    "CaCO2_Plastic"            => [ "2404-NGD-067", "2404-NGD-068", "2404-NGD-069" ],
    "HCA7_Plastic"             => [ "2404-NGD-143", "2404-NGD-210", "2404-NGD-211" ],
    "RKO1_Plastic"             => [ "2404-NGD-045", "2404-NGD-046", "2404-NGD-047" ],
    "RKO1_Horizon_Plastic"     => [ "2404-NGD-159", "2404-NGD-212", "2404-NGD-214" ],
    "RKO1_Horizon_Rectal"      => [ "2404-NGD-174", "2404-NGD-176", "2404-NGD-177" ],
    "RKO1_BRAF_V600E_Plastic"  => [ "2404-NGD-215", "2404-NGD-216", "2404-NGD-217" ],
    "RKO1_BRAF_V600E_Rectal"   => [ "2404-NGD-180", "2404-NGD-184", "2404-NGD-187" ],
    "RKO1_BRAF_Plastic"        => [ "2404-NGD-164", "2404-NGD-166", "2404-NGD-219" ],
    "RKO1_BRAF_Rectal"         => [ "2404-NGD-188", "2404-NGD-190", "2404-NGD-205" ],
    "HT29_Plastic"             => [ "2404-NGD-030", "2404-NGD-031", "2404-NGD-032" ],
    "HT29_Rectal"              => [ "2404-NGD-077", "2404-NGD-078", "2404-NGD-079" ],
    "DiFi_Plastic"             => [ "2404-NGD-070", "2404-NGD-071", "2404-NGD-072" ],
    "Fet1_Plastic"             => [ "2404-NGD-062", "2404-NGD-063", "2404-NGD-102" ],
    "Fet1_Rectal"              => [ "2404-NGD-170", "2404-NGD-171", "2404-NGD-208" ],
    "HT55_Plastic"             => [ "2404-NGD-064", "2404-NGD-066", "2404-NGD-101" ],
  },
  pairs => {

    #plastic vs tumor
    "HCT116_Plastic_vs_HCT116_Rectal"                     => [ "HCT116_Plastic",           "HCT116_Rectal" ],
    "HCT116_Kras_G13D_Plastic_vs_HCT116_Kras_G13D_Rectal" => [ "HCT116_Kras_G13D_Plastic", "HCT116_Kras_G13D_Rectal" ],
    "DLD1_Plastic_vs_DLD1_Rectal"                         => [ "DLD1_Plastic",             "DLD1_Rectal" ],
    "DKO1_Plastic_vs_DKO1_Rectal"                         => [ "DKO1_Plastic",             "DKO1_Rectal" ],
    "SW620_Plastic_vs_SW620_Rectal"                       => [ "SW620_Plastic",            "SW620_Rectal" ],
    "KM12SM_Plastic_vs_KM12SM_Rectal"                     => [ "KM12SM_Plastic",           "KM12SM_Rectal" ],
    "RKO1_Horizon_Plastic_vs_RKO1_Horizon_Rectal"         => [ "RKO1_Horizon_Plastic",     "RKO1_Horizon_Rectal" ],
    "RKO1_BRAF_V600E_Plastic_vs_RKO1_BRAF_V600E_Rectal"   => [ "RKO1_BRAF_V600E_Plastic",  "RKO1_BRAF_V600E_Rectal" ],
    "RKO1_BRAF_Plastic_vs_RKO1_BRAF_Rectal"               => [ "RKO1_BRAF_Plastic",        "RKO1_BRAF_Rectal" ],
    "HT29_Plastic_vs_HT29_Rectal"                         => [ "HT29_Plastic",             "HT29_Rectal" ],
    "Fet1_Plastic_vs_Fet1_Rectal"                         => [ "Fet1_Plastic",             "Fet1_Rectal" ],

    #plastic vs plastic
    "HCT116_Plastic_vs_HCT116_Horizon_Plastic"     => [ "HCT116_Plastic",    "HCT116_Horizon_Plastic" ],
    "KM12C_Plastic_vs_KM12SM_Plastic"              => [ "KM12C_Plastic",     "KM12SM_Plastic" ],
    "DKO1_Plastic_vs_DKS8_Plastic"                 => [ "DKO1_Plastic",      "DKS8_Plastic" ],
    "DKO1_Plastic_vs_DLD1_Plastic"                 => [ "DKO1_Plastic",      "DLD1_Plastic" ],
    "RKO1_Plastic_vs_RKO1_Horizon_Plastic"         => [ "RKO1_Plastic",      "RKO1_Horizon_Plastic" ],
    "SW480_Plastic_vs_SW620_Plastic"               => [ "SW480_Plastic",     "SW620_Plastic" ],
    "RKO1_BRAF_Plastic_vs_RKO1_BRAF_V600E_Plastic" => [ "RKO1_BRAF_Plastic", "RKO1_BRAF_V600E_Plastic" ],

    #tumor vs tumor
    "HCT116_Kras_G13D_Rectal_vs_HCT116_Kras_Rectal" => [ "HCT116_Kras_G13D_Rectal", "HCT116_Kras_Rectal" ],
    "RKO1_BRAF_Rectal_vs_RKO1_BRAF_V600E_Rectal"    => [ "RKO1_BRAF_Rectal",        "RKO1_BRAF_V600E_Rectal" ],
  },
  fastqc => {
    class      => "FastQC",
    perform    => 0,
    target_dir => "${target_dir}/fastqc",
    option     => "",
    source_ref => "fastqfiles",
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  tophat2 => {
    class                => "Tophat2",
    perform              => 0,
    target_dir           => "${target_dir}/tophat2",
    option               => "--segment-length 25 -r 0 -p 8",
    source_ref           => "fastqfiles",
    transcript_gtf       => $transcript_gtf,
    transcript_gtf_index => $transcript_gtf_index,
    bowtie2_index        => $bowtie2_index,
    sh_direct            => 0,
    pbs                  => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
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
  datatable => {
    class         => "CQSDatatable",
    perform       => 0,
    target_dir    => "${target_dir}/datatable",
    option        => "-p ENSG",
    source_ref    => "htseqcount",
    name_map_file => "/data/cqs/shengq1/reference/hg19/hg19.gene.map",
    cqs_tools     => "/home/shengq1/cqstools/CQS.Tools.exe",
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
    perform       => 1,
    target_dir    => "${target_dir}/deseq2",
    option        => "",
    source_ref    => "pairs",
    groups_ref    => "groups",
    countfile_ref => "datatable",
    sh_direct     => 1,
    pbs           => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "10",
      "mem"      => "10gb"
    },
  },
};

performConfig($config);

1;
