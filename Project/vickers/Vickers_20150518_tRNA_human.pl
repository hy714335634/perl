#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;

my $bowtie2_index = "/scratch/cqs/shengq1/references/hg19_16569_MT/bowtie2_index/hg19_16569_MT";
my $cqstools      = '/home/shengq1/cqstools/CQS.Tools.exe';

my $config = {
  'general' => {
    'cluster'   => 'slurm',
    'task_name' => '20150518_tRNA'
  },
  'files' => {
    'KCVH01' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH1_S6_R1_001.fastq.gz'],
    'KCVH02' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH2_S8_R1_001.fastq.gz'],
    'KCVH03' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH3_S9_R1_001.fastq.gz'],
    'KCVH04' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH4_S10_R1_001.fastq.gz'],
    'KCVH05' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH5_S11_R1_001.fastq.gz'],
    'KCVH06' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH6_S12_R1_001.fastq.gz'],
    'KCVH07' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH7_S13_R1_001.fastq.gz'],
    'KCVH08' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH8_S14_R1_001.fastq.gz'],
    'KCVH09' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH9_S15_R1_001.fastq.gz'],
    'KCVH10' => ['/gpfs21/scratch/cqs/shengq1/vickers/data/20150515_tRNA/KCVH10_S7_R1_001.fastq.gz'],
  },
  'fastqc_pre_trim' => {
    'pbs' => {
      'email'    => 'quanhu.sheng@vanderbilt.edu',
      'walltime' => '2',
      'mem'      => '10gb',
      'nodes'    => '1:ppn=1'
    },
    'source_ref' => 'files',
    'cluster'    => 'slurm',
    'perform'    => 1,
    'class'      => 'QC::FastQC',
    'target_dir' => '/scratch/cqs/shengq1/vickers/20150518_tRNA_human/fastqc_pre_trim',
    'option'     => ''
  },
  'fastqc_pre_trim_summary' => {
    'pbs' => {
      'email'    => 'quanhu.sheng@vanderbilt.edu',
      'walltime' => '2',
      'mem'      => '10gb',
      'nodes'    => '1:ppn=1'
    },
    'cluster'    => 'slurm',
    'perform'    => 1,
    'cqstools'   => '/home/shengq1/cqstools/CQS.Tools.exe',
    'class'      => 'QC::FastQCSummary',
    'target_dir' => '/scratch/cqs/shengq1/vickers/20150518_tRNA_human/fastqc_pre_trim',
    'option'     => ''
  },
  'cutadapt' => {
    'pbs' => {
      'email'    => 'quanhu.sheng@vanderbilt.edu',
      'walltime' => '24',
      'mem'      => '20gb',
      'nodes'    => '1:ppn=1'
    },
    'extension'  => '_clipped.fastq',
    'cluster'    => 'slurm',
    'sh_direct'  => 1,
    'perform'    => 1,
    'target_dir' => '/scratch/cqs/shengq1/vickers/20150518_tRNA_human/cutadapt',
    'source_ref' => 'files',
    'adapter'    => 'AGATCGGAAGAG',
    'option'     => '-O 10 -m 16',
    'class'      => 'Cutadapt'
  },
  'fastqc_post_trim' => {
    'pbs' => {
      'email'    => 'quanhu.sheng@vanderbilt.edu',
      'walltime' => '2',
      'mem'      => '10gb',
      'nodes'    => '1:ppn=1'
    },
    'source_ref' => [ 'cutadapt', '.fastq.gz' ],
    'cluster'    => 'slurm',
    'perform'    => 1,
    'class'      => 'QC::FastQC',
    'target_dir' => '/scratch/cqs/shengq1/vickers/20150518_tRNA_human/fastqc_post_trim',
    'option'     => ''
  },
  'fastqc_post_trim_summary' => {
    'pbs' => {
      'email'    => 'quanhu.sheng@vanderbilt.edu',
      'walltime' => '2',
      'mem'      => '10gb',
      'nodes'    => '1:ppn=1'
    },
    'cluster'    => 'slurm',
    'perform'    => 1,
    'cqstools'   => $cqstools,
    'class'      => 'QC::FastQCSummary',
    'target_dir' => '/scratch/cqs/shengq1/vickers/20150518_tRNA_human/fastqc_post_trim',
    'option'     => ''
  },
  'identical' => {
    'pbs' => {
      'email'    => 'quanhu.sheng@vanderbilt.edu',
      'walltime' => '24',
      'mem'      => '20gb',
      'nodes'    => '1:ppn=1'
    },
    'cluster'    => 'slurm',
    'extension'  => '_clipped_identical.fastq.gz',
    'sh_direct'  => 1,
    'perform'    => 1,
    'target_dir' => '/scratch/cqs/shengq1/vickers/20150518_tRNA_human/identical',
    'source_ref' => [ 'cutadapt', '.fastq.gz' ],
    'cqstools'   => '/home/shengq1/cqstools/CQS.Tools.exe',
    'class'      => 'FastqIdentical',
    'option'     => ''
  },
  check_cca => {
    class              => "SmallRNA::TGIRTCheckCCA",
    perform            => 1,
    target_dir         => "/scratch/cqs/shengq1/vickers/20150518_tRNA_human/check_cca",
    option             => "",
    source_ref         => [ 'identical', '.fastq.gz$' ],
    untrimmedFastq_ref => "files",
    cqs_tools          => '/home/shengq1/cqstools/CQS.Tools.exe',
    sh_direct          => 0,
    pbs                => {
      "email"    => 'quanhu.sheng@vanderbilt.edu',
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "10gb"
    },
  },
  fastq_trna => {
    class        => "SmallRNA::TGIRTNTA",
    perform      => 1,
    target_dir   => "/scratch/cqs/shengq1/vickers/20150518_tRNA_human/fastq_trna",
    option       => "",
    extension    => '_clipped_identical_trna.fastq.gz',
    source_ref   => [ 'identical', '.fastq.gz$' ],
    ccaFile_ref  => "check_cca",
    seqcount_ref => [ 'identical', '.dupcount$' ],
    cqs_tools    => '/home/shengq1/cqstools/CQS.Tools.exe',
    sh_direct    => 0,
    pbs          => {
      "email"    => 'quanhu.sheng@vanderbilt.edu',
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "10gb"
    },
  },
  star_tRNA => {
    class                     => "Alignment::STAR",
    perform                   => 1,
    target_dir                => "/scratch/cqs/shengq1/vickers/20150518_tRNA_human/star_tRNA",
    option                    => "--outSAMunmapped Within --alignIntronMax 117 --outFilterMismatchNoverLmax 0.05 --clip5pNbases 3 --alignEndsType EndToEnd --outSAMattributes NH HI NM MD AS XS",
    source_ref                => [ 'fastq_trna', '.*.gz$' ],
    genome_dir                => "/scratch/cqs/shengq1/references/hg19_16569_M/STAR_index_v37.75_2.4.0j_sjdb75",
    output_sort_by_coordinate => 1,
    output_unsorted           => 1,
    sh_direct                 => 0,
    pbs                       => {
      "email"    => 'quanhu.sheng@vanderbilt.edu',
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },
  star_otherSmallRNA => {
    class                     => "Alignment::STAR",
    perform                   => 1,
    target_dir                => "/scratch/cqs/shengq1/vickers/20150518_tRNA_human/star_otherSmallRNA",
    option                    => "--outSAMunmapped Within --alignIntronMax 1 --outFilterMismatchNoverLmax 0.05 --alignEndsType EndToEnd --outSAMattributes NH HI NM MD AS XS",
    source_ref                => [ 'identical', '.fastq.gz$' ],
    genome_dir                => "/scratch/cqs/shengq1/references/hg19_16569_M/STAR_index_v37.75_2.4.0j_sjdb75",
    output_sort_by_coordinate => 1,
    output_unsorted           => 1,
    sh_direct                 => 1,
    pbs                       => {
      "email"    => 'quanhu.sheng@vanderbilt.edu',
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },
  star_tgirt_count => {
    class              => "SmallRNA::TGIRTCount",
    perform            => 1,
    target_dir         => "/scratch/cqs/shengq1/vickers/20150518_tRNA_human/tgirt_count",
    option             => "",
    source_ref         => [ "star_tRNA", "_Aligned.out.bam" ],
    other_smallrna_ref => [ "star_otherSmallRNA", "_Aligned.out.bam" ],
    fastq_files_ref    => "identical",
    seqcount_ref       => [ "identical", ".dupcount\$" ],
    cqs_tools          => $cqstools,
    coordinate_file    => "/scratch/cqs/shengq1/references/smallrna/hg19_miRBase20_ucsc-tRNA_ensembl75.bed",
    fasta_file         => "/scratch/cqs/shengq1/references/smallrna/hg19_miRBase20_ucsc-tRNA_ensembl75.bed.fa",
    sh_direct          => 1,
    pbs                => {
      "email"    => 'quanhu.sheng@vanderbilt.edu',
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "30gb"
    },
  },

  'star_tgirt_category' => {
    'class'      => 'CQS::SmallRNACategory',
    'option'     => '',
    'sh_direct'  => 1,
    'perform'    => 1,
    'target_dir' => '/scratch/cqs/shengq1/vickers/20150518_tRNA_human/star_tgirt_category',
    'source_ref' => [ 'star_tgirt_count', '.info$' ],
    'cqs_tools'  => $cqstools,
    'pbs' => {
      'email'    => 'quanhu.sheng@vanderbilt.edu',
      'walltime' => '72',
      'mem'      => '40gb',
      'nodes'    => '1:ppn=1'
    },
  },
};

#performConfig($config);
#performTask($config, "check_cca");
#performTask($config, "fastq_trna");
performTask( $config, "star_tgirt_category" );

#performTask( $config, "star_otherSmallRNA" );

1;

