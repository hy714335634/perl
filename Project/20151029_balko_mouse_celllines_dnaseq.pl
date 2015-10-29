#!/usr/bin/perl
use strict;
use warnings;

use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;
use CQS::ClassFactory;

my $target_dir = "/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines";
my $email      = "quanhu.sheng\@vanderbilt.edu";

my $cqstools   = "/home/shengq1/cqstools/CQS.Tools.exe";
my $glmvc      = "/home/shengq1/glmvc/glmvc.exe";
my $mutect     = "/home/shengq1/local/bin/mutect-1.1.7.jar";
my $gatk_jar   = "/home/shengq1/local/bin/GATK/GenomeAnalysisTK.jar";
my $picard_jar = "/scratch/cqs/shengq1/local/bin/picard/picard.jar";
my $conifer    = "/home/shengq1/pylibs/bin/conifer.py";
my $qc3_perl   = "/scratch/cqs/shengq1/local/bin/qc3/qc3.pl";

my $bwa_fasta      = "/scratch/cqs/shengq1/references/hg19_16569_MT/bwa_index_0.7.12/hg19_16569_MT.fa";
my $transcript_gtf = "/scratch/cqs/shengq1/references/ensembl_gtf/v75/Homo_sapiens.GRCh37.75.MT.gtf";
my $name_map_file  = "/scratch/cqs/shengq1/references/ensembl_gtf/v75/Homo_sapiens.GRCh37.75.MT.map";

my $dbsnp  = "/scratch/cqs/shengq1/references/dbsnp/human_GRCh37_v142_16569_MT.vcf";
my $hapmap = "/scratch/cqs/shengq1/references/gatk/b37/hapmap_3.3.b37.vcf";
my $omni   = "/scratch/cqs/shengq1/references/gatk/b37/1000G_omni2.5.b37.vcf";
my $g1000  = "/scratch/cqs/shengq1/references/gatk/b37/1000G_phase1.snps.high_confidence.b37.vcf";
my $mills  = "/scratch/cqs/shengq1/references/gatk/b37/Mills_and_1000G_gold_standard.indels.b37.vcf";

my $cosmic    = "/scratch/cqs/shengq1/references/cosmic/cosmic_v71_hg19_16569_MT.vcf";
my $affy_file = "/data/cqs/shengq1/reference/affy/HG-U133_Plus_2.na33.annot.csv";

my $annovar_protocol  = "refGene,snp138,cosmic70";
my $annovar_operation = "g,f,f";
my $annovar_param     = "-protocol ${annovar_protocol} -operation ${annovar_operation} --remove";
my $annovar_db        = "/scratch/cqs/shengq1/references/annovar/humandb/";
my $rnaediting_db     = "/data/cqs/shengq1/reference/rnaediting/hg19.txt";

my $covered_bed = "/scratch/cqs/shengq1/references/sureselect/S0276129_Mouse_All_Exon_V1/S0276129_Regions.bed";

my $cluster = "slurm";

my $config = {
  general => { task_name => "bmc" },

  files => {
    "N04_DUSP4flox_LACZ" => [
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-1_1_sequence.txt.gz",
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-1_2_sequence.txt.gz"
    ],
    "N07_DUSP4flox_MYC" => [
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-3_1_sequence.txt.gz",
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-3_2_sequence.txt.gz"
    ],
    "N05_DUSP4flox_Trp53null1_LACZ" => [
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-2_1_sequence.txt.gz",
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-2_2_sequence.txt.gz"
    ],
    "N09_DUSP4flox_Trp53null3_MYC" => [
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-4_1_sequence.txt.gz",
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-4_2_sequence.txt.gz"
    ],
    "N13_DUSP4null_LACZ" => [
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-5_1_sequence.txt.gz",
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-5_2_sequence.txt.gz"
    ],
    "N16_DUSP4null_MYC" => [
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-7_1_sequence.txt.gz",
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-7_2_sequence.txt.gz"
    ],
    "N15_DUSP4null_Trp53null3_LACZ" => [
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-6_1_sequence.txt.gz",
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-6_2_sequence.txt.gz"
    ],
    "N17_DUSP4null_Trp53null1_MYC" => [
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-8_1_sequence.txt.gz",
      "/gpfs21/scratch/cqs/shengq1/dnaseq/20151029_balko_mouse_celllines/data/WES/3162-JMB-8_2_sequence.txt.gz"
    ],
  },
  groups => {
    "N07_DUSP4flox_MYC"             => [ "N04_DUSP4flox_LACZ", "N07_DUSP4flox_MYC" ],
    "N05_DUSP4flox_Trp53null1_LACZ" => [ "N04_DUSP4flox_LACZ", "N05_DUSP4flox_Trp53null1_LACZ" ],
    "N09_DUSP4flox_Trp53null3_MYC"  => [ "N04_DUSP4flox_LACZ", "N09_DUSP4flox_Trp53null3_MYC" ],
    "N13_DUSP4null_LACZ"            => [ "N04_DUSP4flox_LACZ", "N13_DUSP4null_LACZ" ],
    "N16_DUSP4null_MYC"             => [ "N04_DUSP4flox_LACZ", "N16_DUSP4null_MYC" ],
    "N15_DUSP4null_Trp53null3_LACZ" => [ "N04_DUSP4flox_LACZ", "N15_DUSP4null_Trp53null3_LACZ" ],
    "N17_DUSP4null_Trp53null1_MYC"  => [ "N04_DUSP4flox_LACZ", "N17_DUSP4null_Trp53null1_MYC" ],
  },

  fastqc => {
    class      => "QC::FastQC",
    perform    => 1,
    target_dir => "${target_dir}/fastqc",
    option     => "",
    source_ref => "files",
    sh_direct  => 1,
    cluster    => $cluster,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=2",
      "walltime" => "2",
      "mem"      => "40gb"
    },
  },
  fastqc_summary => {
    class      => "QC::FastQCSummary",
    perform    => 1,
    target_dir => "${target_dir}/fastqc",
    option     => "",
    cluster    => $cluster,
    cqstools   => $cqstools,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "2",
      "mem"      => "10gb"
    },
  },
  bwa => {
    class      => "Alignment::BWA",
    perform    => 1,
    target_dir => "${target_dir}/bwa",
    option     => "",
    bwa_index  => $bwa_fasta,
    source_ref => "files",
    picard_jar => $picard_jar,
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  },
  bwa_refine => {
    class       => "GATK::Refine",
    perform     => 1,
    target_dir  => "${target_dir}/bwa_refine",
    option      => "-Xmx40g",
    gatk_option => "--fix_misencoded_quality_scores",
    fasta_file  => $bwa_fasta,
    source_ref  => "bwa",
    vcf_files   => [$dbsnp],
    gatk_jar    => $gatk_jar,
    picard_jar  => $picard_jar,
    sh_direct   => 0,
    sorted      => 1,
    pbs         => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "240",
      "mem"      => "40gb"
    },
  },
  conifer => {
    class       => "CNV::Conifer",
    perform     => 1,
    target_dir  => "${target_dir}/conifer",
    option      => "",
    source_ref  => "bwa",
    conifer     => $conifer,
    bedfile     => $covered_bed,
    isbamsorted => 1,
    sh_direct   => 1,
    pbs         => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "720",
      "mem"      => "10gb"
    },
  },
  cnmops => {
    class       => "CNV::cnMops",
    perform     => 1,
    target_dir  => "${target_dir}/cnmops",
    option      => "",
    source_ref  => "bwa",
    bedfile     => $covered_bed,
    pairmode    => "paired",
    isbamsorted => 1,
    sh_direct   => 1,
    pbs         => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "720",
      "mem"      => "40gb"
    },
  },
  muTect => {
    class        => "GATK::MuTect",
    perform      => 1,
    target_dir   => "${target_dir}/muTect",
    option       => "--min_qscore 20 --filter_reads_with_N_cigar",
    java_option  => "-Xmx40g",
    source_ref   => "bwa_refine",
    groups_ref   => "groups",
    fasta_file   => $bwa_fasta,
    cosmic_file  => $cosmic,
    dbsnp_file   => $dbsnp,
    bychromosome => 0,
    sh_direct    => 0,
    muTect_jar   => $mutect,
    pbs          => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "240",
      "mem"      => "40gb"
    },
  },
  annovar_muTect => {
    class      => "Annotation::Annovar",
    perform    => 1,
    target_dir => "${target_dir}/muTect",
    option     => $annovar_param,
    source_ref => [ "muTect", ".pass.vcf\$" ],
    annovar_db => $annovar_db,
    buildver   => "hg19",
    cqstools   => $cqstools,
    affy_file  => $affy_file,
    sh_direct  => 1,
    isvcf      => 1,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "10gb"
    },
  },
  glmvc => {
    class             => "Variants::GlmvcCall",
    perform           => 1,
    target_dir        => "${target_dir}/glmvc",
    option            => "--glm_pvalue 0.1",
    source_type       => "BAM",
    source_ref        => "bwa_refine",
    groups_ref        => "groups",
    fasta_file        => $bwa_fasta,
    annovar_buildver  => "hg19",
    annovar_protocol  => $annovar_protocol,
    annovar_operation => $annovar_operation,
    rnaediting_db     => $rnaediting_db,
    distance_exon_gtf => $transcript_gtf,
    sh_direct         => 0,
    execute_file      => $glmvc,
    pbs               => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  }
};

performConfig($config);

1;

