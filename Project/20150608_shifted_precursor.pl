#!/usr/bin/perl
use strict;
use warnings;

use CQS::ClassFactory;
use CQS::FileUtils;
use CQS::SystemUtils;
use CQS::ConfigUtils;
use Data::Dumper;

my $target_dir      = "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor";
my $msgf_jar        = "/scratch/cqs/shengq1/local/bin/MSGFPlus/MSGFPlus.jar";
my $msamanda = "/scratch/cqs/shengq1/local/bin/MSAmanda_Standalone_LinuxMac_1.0.0.4485/MSAmanda.exe";
my $proteomicstools = "/home/shengq1/proteomicstools/ProteomicsTools.exe";
my $mod_file        = "/scratch/cqs/shengq1/local/bin/MSGFPlus/Mods.txt";
my $database_human  = "/scratch/cqs/shengq1/proteomics/shifted/rev_Human_uniprot_sprot_v20120613.fasta";
my $database_yeast  = "/scratch/cqs/shengq1/proteomics/shifted/rev_Yeast_uniprot_v20120613.fasta";
my $database_ecoli  = "/scratch/cqs/shengq1/proteomics/shifted/rev_Ecoli_uniprot_v20120613_P4431.fasta";
my $email           = "quanhu.sheng\@vanderbilt.edu";

my $datasets = {
  Elite_CIDIT_Human => {
    source => {
      "20141017Test_DJMa_Cell_04"               => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_04.mgf"],
      "20141017Test_DJMa_Cell_04.minus10dalton" => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_04.minus10dalton.mgf"],
      "20141017Test_DJMa_Cell_04.plus0.1dalton" => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_04.plus0.1dalton.mgf"],
      "20141017Test_DJMa_Cell_04.plus10dalton"  => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_04.plus10dalton.mgf"],
      "20141017Test_DJMa_Cell_05"               => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_05.mgf"],
      "20141017Test_DJMa_Cell_05.minus10dalton" => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_05.minus10dalton.mgf"],
      "20141017Test_DJMa_Cell_05.plus0.1dalton" => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_05.plus0.1dalton.mgf"],
      "20141017Test_DJMa_Cell_05.plus10dalton"  => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_05.plus10dalton.mgf"],
      "20141017Test_DJMa_Cell_06"               => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_06.mgf"],
      "20141017Test_DJMa_Cell_06.minus10dalton" => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_06.minus10dalton.mgf"],
      "20141017Test_DJMa_Cell_06.plus0.1dalton" => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_06.plus0.1dalton.mgf"],
      "20141017Test_DJMa_Cell_06.plus10dalton"  => ["/gpfs21/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/20141017Test_DJMa_Cell_06.plus10dalton.mgf"],
    },
    database              => $database_human,
    MSGF_option           => "-t 20ppm -ti \"0,1\" -tda 0 -m 1 -inst 0 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
    comet_param_file      => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/comet-it.params",
    myrimatch_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/myrimatch-it.config",
    msamanda_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/msamanda-it.config",
  },
  Fusion_CIDIT_Human => {
    source                => {},
    database              => $database_human,
    MSGF_option           => "-t 20ppm -ti \"0,1\" -tda 0 -m 1 -inst 0 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
    comet_param_file      => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/comet-it.params",
    myrimatch_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/myrimatch-it.config",
    msamanda_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/msamanda-it.config",
  },
  Fusion_HCDIT_Yeast => {
    source                => {},
    database              => $database_yeast,
    MSGF_option           => "-t 20ppm -ti \"0,1\" -tda 0 -m 3 -inst 0 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
    comet_param_file      => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/comet-it.params",
    myrimatch_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/myrimatch-it.config",
    msamanda_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/msamanda-it.config",
  },
  Fusion_HCDOT_Human => {
    source                => {},
    database              => $database_human,
    MSGF_option           => "-t 20ppm -ti \"0,1\" -tda 0 -m 3 -inst 3 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
    comet_param_file      => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/comet-ot.params",
    myrimatch_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/myrimatch-ot.config",
    msamanda_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/msamanda-ot.config",
  },
  QExactive_HCDOT_Human => {
    source                => {},
    database              => $database_human,
    MSGF_option           => "-t 20ppm -ti \"0,1\" -tda 0 -m 3 -inst 3 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
    comet_param_file      => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/comet-ot.params",
    myrimatch_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/myrimatch-ot.config",
    msamanda_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/msamanda-ot.config",
  },
  QTOF_Ecoli => {
    source                => {},
    database              => $database_ecoli,
    MSGF_option           => "-t 20ppm -ti \"0,1\" -tda 0 -m 3 -inst 2 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
    comet_param_file      => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/comet-qtof.params",
    myrimatch_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/myrimatch-qtof.config",
    msamanda_config_file => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/parameters/msamanda-qtof.config",
  },
};

my $configall = { general => { task_name => "ShiftedTargetDecoy" }, };

my @sections = ();

for my $dataset ( sort keys %{$datasets} ) {
  $configall->{ $dataset . "_MSGF" } = {
    class      => "Proteomics::Engine::MSGFPlus",
    task_name  => $dataset,
    perform    => 1,
    target_dir => "${target_dir}/$dataset/MSGF",
    option     => $datasets->{$dataset}->{MSGF_option},
    source     => $datasets->{$dataset}->{source},
    msgf_jar   => $msgf_jar,
    mod_file   => $mod_file,
    database   => $datasets->{$dataset}->{database},
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  $configall->{ $dataset . "_MSGF_PSM" } = {
    class           => "Proteomics::Distiller::PSMDistiller",
    task_name       => $dataset,
    perform         => 1,
    target_dir      => "${target_dir}/$dataset/MSGF",
    option          => "-e MSGF -t DTA",
    source_ref      => $dataset . "_MSGF",
    proteomicstools => $proteomicstools,
    sh_direct       => 1,
    pbs             => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  push( @sections, $dataset . "_MSGF" );
  push( @sections, $dataset . "_MSGF_PSM" );

  $configall->{ $dataset . "_comet" } = {
    class           => "Proteomics::Engine::Comet",
    task_name       => $dataset,
    perform         => 1,
    target_dir      => "${target_dir}/$dataset/comet",
    option          => "",
    source          => $datasets->{$dataset}->{source},
    database        => $datasets->{$dataset}->{database},
    param_file      => $datasets->{$dataset}->{comet_param_file},
    proteomicstools => $proteomicstools,
    titleformat     => "DTA",
    sh_direct       => 0,
    pbs             => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  $configall->{ $dataset . "_comet_PSM" } = {
    class           => "Proteomics::Distiller::PSMDistiller",
    task_name       => $dataset,
    perform         => 1,
    target_dir      => "${target_dir}/$dataset/comet",
    option          => "-e Comet -t DTA",
    source_ref      => $dataset . "_comet",
    proteomicstools => $proteomicstools,
    sh_direct       => 1,
    pbs             => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  $configall->{ $dataset . "_comet_rank2_PSM" } = {
    class           => "Proteomics::Distiller::PSMDistiller",
    task_name       => $dataset . "_rank2",
    perform         => 1,
    target_dir      => "${target_dir}/$dataset/comet_rank2",
    option          => "-e Comet -t DTA --rank2",
    source_ref      => $dataset . "_comet",
    proteomicstools => $proteomicstools,
    sh_direct       => 1,
    pbs             => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  push( @sections, $dataset . "_comet" );
  push( @sections, $dataset . "_comet_PSM" );
  push( @sections, $dataset . "_comet_rank2_PSM" );

  $configall->{ $dataset . "_myrimatch" } = {
    class      => "Proteomics::Engine::Myrimatch",
    task_name  => $dataset,
    perform    => 1,
    target_dir => "${target_dir}/$dataset/myrimatch",
    option     => "",
    source     => $datasets->{$dataset}->{source},
    cfgfile    => $datasets->{$dataset}->{myrimatch_config_file},
    database   => $datasets->{$dataset}->{database},
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  $configall->{ $dataset . "_myrimatch_PSM" } = {
    class           => "Proteomics::Distiller::PSMDistiller",
    task_name       => $dataset,
    perform         => 1,
    target_dir      => "${target_dir}/$dataset/myrimatch",
    option          => "-e MyriMatch -t DTA",
    source_ref      => $dataset . "_myrimatch",
    proteomicstools => $proteomicstools,
    sh_direct       => 1,
    pbs             => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  push( @sections, $dataset . "_myrimatch" );
  push( @sections, $dataset . "_myrimatch_PSM" );

  $configall->{ $dataset . "_msamanda" } = {
    class      => "Proteomics::Engine::Msamanda",
    task_name  => $dataset,
    perform    => 1,
    target_dir => "${target_dir}/$dataset/msamanda",
    option     => "",
    source     => $datasets->{$dataset}->{source},
    executable => $msamanda,
    cfgfile    => $datasets->{$dataset}->{msamanda_config_file},
    database   => $datasets->{$dataset}->{database},
    sh_direct  => 0,
    pbs        => {
      "email"    => $email,
      "nodes"    => "1:ppn=8",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  $configall->{ $dataset . "_msamanda_PSM" } = {
    class           => "Proteomics::Distiller::PSMDistiller",
    task_name       => $dataset,
    perform         => 1,
    target_dir      => "${target_dir}/$dataset/msamanda",
    option          => "-e MSAmanda -t DTA",
    source_ref      => $dataset . "_msamanda",
    proteomicstools => $proteomicstools,
    sh_direct       => 1,
    pbs             => {
      "email"    => $email,
      "nodes"    => "1:ppn=1",
      "walltime" => "72",
      "mem"      => "40gb"
    },
  };

  push( @sections, $dataset . "_msamanda" );
  push( @sections, $dataset . "_msamanda_PSM" );
}

$configall->{sequencetask} = {
  class      => "CQS::SequenceTask",
  perform    => 1,
  target_dir => "${target_dir}/sequencetask",
  option     => "",
  source     => { step_1 => \@sections },
  sh_direct  => 0,
  pbs        => {
    "email"    => $email,
    "nodes"    => "1:ppn=8",
    "walltime" => "72",
    "mem"      => "40gb"
  },
};

#print Dumper($configall);
performConfig($configall);

#my $config = {
#  Elite_CIDIT_Human_MSGFPlus => {
#    class      => "Proteomics::Engine::MSGFPlus",
#    perform    => 1,
#    target_dir => "${target_dir}/Elite_CIDIT_Human/MSGF",
#    option     => "-t 20ppm -ti \"0,1\" -tda 0 -m 1 -inst 0 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
#    source     => {
#      "Elite_CIDIT_Human"               => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/Elite_CIDIT_Human.mgf"],
#      "Elite_CIDIT_Human.minus10dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/Elite_CIDIT_Human.minus10dalton.mgf"],
#      "Elite_CIDIT_Human.plus0.1dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/Elite_CIDIT_Human.plus0.1dalton.mgf"],
#      "Elite_CIDIT_Human.plus10dalton"  => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/Elite_CIDIT_Human.plus10dalton.mgf"],
#    },
#    msgf_jar  => $msgf_jar,
#    mod_file  => $mod_file,
#    database  => $database_human,
#    sh_direct => 0,
#    pbs       => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#  Elite_CIDIT_Human_Comet => {
#    class      => "Proteomics::Engine::Comet",
#    perform    => 1,
#    target_dir => "${target_dir}/Elite_CIDIT_Human/Comet",
#    option     => "",
#    source     => {
#      "Elite_CIDIT_Human"               => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/Elite_CIDIT_Human.mgf"],
#      "Elite_CIDIT_Human.minus10dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/Elite_CIDIT_Human.minus10dalton.mgf"],
#      "Elite_CIDIT_Human.plus0.1dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/Elite_CIDIT_Human.plus0.1dalton.mgf"],
#      "Elite_CIDIT_Human.plus10dalton"  => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/mgf/Elite_CIDIT_Human.plus10dalton.mgf"],
#    },
#    param_file      => "/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Elite_CIDIT_Human/comet.params",
#    proteomicstools => $proteomicstools,
#    titleformat     => "DTA",
#    database        => $database_human,
#    sh_direct       => 0,
#    pbs             => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#  Fusion_CIDIT_Human_MSGFPlus => {
#    class      => "Proteomics::Engine::MSGFPlus",
#    perform    => 1,
#    target_dir => "${target_dir}/Fusion_CIDIT_Human/MSGF",
#    option     => "-t 20ppm -ti \"0,1\" -tda 0 -m 1 -inst 0 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
#    source     => {
#      "Fusion_CIDIT_Human"               => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_CIDIT_Human/mgf/Fusion_CIDIT_Human.mgf"],
#      "Fusion_CIDIT_Human.minus10dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_CIDIT_Human/mgf/Fusion_CIDIT_Human.minus10dalton.mgf"],
#      "Fusion_CIDIT_Human.plus0.1dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_CIDIT_Human/mgf/Fusion_CIDIT_Human.plus0.1dalton.mgf"],
#      "Fusion_CIDIT_Human.plus10dalton"  => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_CIDIT_Human/mgf/Fusion_CIDIT_Human.plus10dalton.mgf"],
#    },
#    msgf_jar  => $msgf_jar,
#    mod_file  => $mod_file,
#    database  => $database_human,
#    sh_direct => 0,
#    pbs       => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#  Fusion_HCDIT_Yeast_MSGFPlus => {
#    class      => "Proteomics::Engine::MSGFPlus",
#    perform    => 1,
#    target_dir => "${target_dir}/Fusion_HCDIT_Yeast/MSGF",
#    option     => "-t 20ppm -ti \"0,1\" -tda 0 -m 3 -inst 0 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
#    source     => {
#      "Fusion_HCDIT_Yeast"               => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_HCDIT_Yeast/mgf/Fusion_HCDIT_Yeast.mgf"],
#      "Fusion_HCDIT_Yeast.minus10dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_HCDIT_Yeast/mgf/Fusion_HCDIT_Yeast.minus10dalton.mgf"],
#      "Fusion_HCDIT_Yeast.plus0.1dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_HCDIT_Yeast/mgf/Fusion_HCDIT_Yeast.plus0.1dalton.mgf"],
#      "Fusion_HCDIT_Yeast.plus10dalton"  => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_HCDIT_Yeast/mgf/Fusion_HCDIT_Yeast.plus10dalton.mgf"],
#    },
#    msgf_jar  => $msgf_jar,
#    mod_file  => $mod_file,
#    database  => $database_yeast,
#    sh_direct => 0,
#    pbs       => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#  Fusion_HCDOT_Human_MSGFPlus => {
#    class      => "Proteomics::Engine::MSGFPlus",
#    perform    => 1,
#    target_dir => "${target_dir}/Fusion_HCDOT_Human/MSGF",
#    option     => "-t 20ppm -ti \"0,1\" -tda 0 -m 3 -inst 3 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
#    source     => {
#      "Fusion_HCDOT_Human"               => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_HCDOT_Human/mgf/Fusion_HCDOT_Human.mgf"],
#      "Fusion_HCDOT_Human.minus10dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_HCDOT_Human/mgf/Fusion_HCDOT_Human.minus10dalton.mgf"],
#      "Fusion_HCDOT_Human.plus0.1dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_HCDOT_Human/mgf/Fusion_HCDOT_Human.plus0.1dalton.mgf"],
#      "Fusion_HCDOT_Human.plus10dalton"  => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/Fusion_HCDOT_Human/mgf/Fusion_HCDOT_Human.plus10dalton.mgf"],
#    },
#    msgf_jar  => $msgf_jar,
#    mod_file  => $mod_file,
#    database  => $database_human,
#    sh_direct => 0,
#    pbs       => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#  QExactive_HCDOT_Human_MSGFPlus => {
#    class      => "Proteomics::Engine::MSGFPlus",
#    perform    => 1,
#    target_dir => "${target_dir}/QExactive_HCDOT_Human/MSGF",
#    option     => "-t 20ppm -ti \"0,1\" -tda 0 -m 3 -inst 3 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
#    source     => {
#      "QExactive_HCDOT_Human"               => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/QExactive_HCDOT_Human/mgf/QExactive_HCDOT_Human.mgf"],
#      "QExactive_HCDOT_Human.minus10dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/QExactive_HCDOT_Human/mgf/QExactive_HCDOT_Human.minus10dalton.mgf"],
#      "QExactive_HCDOT_Human.plus0.1dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/QExactive_HCDOT_Human/mgf/QExactive_HCDOT_Human.plus0.1dalton.mgf"],
#      "QExactive_HCDOT_Human.plus10dalton"  => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/QExactive_HCDOT_Human/mgf/QExactive_HCDOT_Human.plus10dalton.mgf"],
#    },
#    msgf_jar  => $msgf_jar,
#    mod_file  => $mod_file,
#    database  => $database_human,
#    sh_direct => 0,
#    pbs       => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#  QTOF_Ecoli_MSGFPlus => {
#    class      => "Proteomics::Engine::MSGFPlus",
#    perform    => 1,
#    target_dir => "${target_dir}/QTOF_Ecoli/MSGF",
#    option     => "-t 20ppm -ti \"0,1\" -tda 0 -m 3 -inst 2 -e 1 -protocol 5 -ntt 2 -n 1 -addFeatures 1",
#    source     => {
#      "QTOF_Ecoli"               => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/QTOF_Ecoli/mgf/QTOF_Ecoli.mgf"],
#      "QTOF_Ecoli.minus10dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/QTOF_Ecoli/mgf/QTOF_Ecoli.minus10dalton.mgf"],
#      "QTOF_Ecoli.plus0.1dalton" => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/QTOF_Ecoli/mgf/QTOF_Ecoli.plus0.1dalton.mgf"],
#      "QTOF_Ecoli.plus10dalton"  => ["/scratch/cqs/shengq1/proteomics/20150608_shifted_precursor/QTOF_Ecoli/mgf/QTOF_Ecoli.plus10dalton.mgf"],
#    },
#    msgf_jar  => $msgf_jar,
#    mod_file  => $mod_file,
#    database  => $database_ecoli,
#    sh_direct => 0,
#    pbs       => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#  MSGFPlus_Distiller => {
#    class      => "Proteomics::Distiller::PSMDistiller",
#    perform    => 1,
#    target_dir => "${target_dir}/PSMDistillerMSGFPlus",
#    option     => "-e MSGF -t DTA",
#    source_ref => [
#      "Elite_CIDIT_Human_MSGFPlus",  "Fusion_CIDIT_Human_MSGFPlus",    "Fusion_HCDIT_Yeast_MSGFPlus", "Fusion_HCDIT_Yeast_MSGFPlus",
#      "Fusion_HCDOT_Human_MSGFPlus", "QExactive_HCDOT_Human_MSGFPlus", "QTOF_Ecoli_MSGFPlus"
#    ],
#    proteomicstools => $proteomicstools,
#    sh_direct       => 1,
#    pbs             => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#  sequencetask => {
#    class      => "CQS::SequenceTask",
#    perform    => 1,
#    target_dir => "${target_dir}/sequencetask",
#    option     => "",
#    source     => {
#      step_1 => [
#        "Elite_CIDIT_Human_MSGFPlus",  "Fusion_CIDIT_Human_MSGFPlus",    "Fusion_HCDIT_Yeast_MSGFPlus", "Fusion_HCDIT_Yeast_MSGFPlus",
#        "Fusion_HCDOT_Human_MSGFPlus", "QExactive_HCDOT_Human_MSGFPlus", "QTOF_Ecoli_MSGFPlus"
#      ],
#    },
#    sh_direct => 1,
#    pbs       => {
#      "email"    => $email,
#      "nodes"    => "1:ppn=8",
#      "walltime" => "72",
#      "mem"      => "40gb"
#    },
#  },
#};
#
##performConfig($config);
#performTask( $config, "Elite_CIDIT_Human_Comet" );

1;
