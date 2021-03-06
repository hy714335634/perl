#!/usr/bin/perl
use strict;
use warnings;

use CQS::PerformSmallRNA;

my $def = {

  #General options
  task_name  => "2868",
  email      => "quanhu.sheng\@vanderbilt.edu",
  target_dir => "/scratch/cqs/shengq1/smallRNA/20151222_guoyan_smallRNA_2868_human",
  max_thread => 8,

  #Default software parameter (don't change it except you really know it)
  fastq_remove_N        => 1,
  cqstools              => "/home/shengq1/cqstools/CQS.Tools.exe",
  mapped_extract        => 1,
  search_unmapped_reads => 0,

  #Data
  files => {
    "CMS-001" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-1_1_sequence.txt.gz"],
    "CMS-002" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-2_1_sequence.txt.gz"],
    "CMS-003" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-3_1_sequence.txt.gz"],
    "CMS-004" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-4_1_sequence.txt.gz"],
    "CMS-005" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-5_1_sequence.txt.gz"],
    "CMS-006" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-6_1_sequence.txt.gz"],
    "CMS-007" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-7_1_sequence.txt.gz"],
    "CMS-008" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-8_1_sequence.txt.gz"],
    "CMS-009" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-9_1_sequence.txt.gz"],
    "CMS-010" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-10_1_sequence.txt.gz"],
    "CMS-025" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-25_1_sequence.txt.gz"],
    "CMS-026" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-26_1_sequence.txt.gz"],
    "CMS-027" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-27_1_sequence.txt.gz"],
    "CMS-028" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-28_1_sequence.txt.gz"],
    "CMS-029" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-29_1_sequence.txt.gz"],
    "CMS-030" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-30_1_sequence.txt.gz"],
    "CMS-031" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-31_1_sequence.txt.gz"],
    "CMS-032" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-32_1_sequence.txt.gz"],
    "CMS-033" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-33_1_sequence.txt.gz"],
    "CMS-034" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-34_1_sequence.txt.gz"],
    "CMS-035" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-35_1_sequence.txt.gz"],
    "CMS-036" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-36_1_sequence.txt.gz"],
    "CMS-037" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-37_1_sequence.txt.gz"],
    "CMS-038" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-38_1_sequence.txt.gz"],
    "CMS-039" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-39_1_sequence.txt.gz"],
    "CMS-040" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-40_1_sequence.txt.gz"],
    "CMS-041" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-41_1_sequence.txt.gz"],
    "CMS-042" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-42_1_sequence.txt.gz"],
    "CMS-043" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-43_1_sequence.txt.gz"],
    "CMS-044" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-44_1_sequence.txt.gz"],
    "CMS-045" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-45_1_sequence.txt.gz"],
    "CMS-046" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-46_1_sequence.txt.gz"],
    "CMS-047" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-47_1_sequence.txt.gz"],
    "CMS-048" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-48_1_sequence.txt.gz"],
    "CMS-049" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-49_1_sequence.txt.gz"],
    "CMS-050" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-50_1_sequence.txt.gz"],
    "CMS-051" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-51_1_sequence.txt.gz"],
    "CMS-052" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-52_1_sequence.txt.gz"],
    "CMS-053" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-53_1_sequence.txt.gz"],
    "CMS-054" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-54_1_sequence.txt.gz"],
    "CMS-055" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-55_1_sequence.txt.gz"],
    "CMS-056" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-56_1_sequence.txt.gz"],
    "CMS-057" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-57_1_sequence.txt.gz"],
    "CMS-058" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-58_1_sequence.txt.gz"],
    "CMS-059" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-59_1_sequence.txt.gz"],
    "CMS-060" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-60_1_sequence.txt.gz"],
    "CMS-061" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-61_1_sequence.txt.gz"],
    "CMS-062" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-62_1_sequence.txt.gz"],
    "CMS-063" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-63_1_sequence.txt.gz"],
    "CMS-064" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-64_1_sequence.txt.gz"],
    "CMS-065" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-65_1_sequence.txt.gz"],
    "CMS-066" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-66_1_sequence.txt.gz"],
    "CMS-067" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-67_1_sequence.txt.gz"],
    "CMS-068" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-68_1_sequence.txt.gz"],
    "CMS-069" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-69_1_sequence.txt.gz"],
    "CMS-070" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-70_1_sequence.txt.gz"],
    "CMS-071" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-71_1_sequence.txt.gz"],
    "CMS-072" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-72_1_sequence.txt.gz"],
    "CMS-073" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-73_1_sequence.txt.gz"],
    "CMS-074" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-74_1_sequence.txt.gz"],
    "CMS-075" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-75_1_sequence.txt.gz"],
    "CMS-076" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-76_1_sequence.txt.gz"],
    "CMS-077" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-77_1_sequence.txt.gz"],
    "CMS-078" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-78_1_sequence.txt.gz"],
    "CMS-079" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-79_1_sequence.txt.gz"],
    "CMS-080" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-80_1_sequence.txt.gz"],
    "CMS-081" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-81_1_sequence.txt.gz"],
    "CMS-082" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-82_1_sequence.txt.gz"],
    "CMS-083" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-83_1_sequence.txt.gz"],
    "CMS-084" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-84_1_sequence.txt.gz"],
    "CMS-085" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-85_1_sequence.txt.gz"],
    "CMS-086" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-86_1_sequence.txt.gz"],
    "CMS-087" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-87_1_sequence.txt.gz"],
    "CMS-088" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-88_1_sequence.txt.gz"],
    "CMS-089" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-89_1_sequence.txt.gz"],
    "CMS-090" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-90_1_sequence.txt.gz"],
    "CMS-091" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-91_1_sequence.txt.gz"],
    "CMS-092" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-92_1_sequence.txt.gz"],
    "CMS-093" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-93_1_sequence.txt.gz"],
    "CMS-094" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-94_1_sequence.txt.gz"],
    "CMS-095" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-95_1_sequence.txt.gz"],
    "CMS-096" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-96_1_sequence.txt.gz"],
    "CMS-097" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-97_1_sequence.txt.gz"],
    "CMS-098" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-98_1_sequence.txt.gz"],
    "CMS-099" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-99_1_sequence.txt.gz"],
    "CMS-100" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-100_1_sequence.txt.gz"],
    "CMS-101" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-101_1_sequence.txt.gz"],
    "CMS-102" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-102_1_sequence.txt.gz"],
    "CMS-103" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-103_1_sequence.txt.gz"],
    "CMS-104" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-104_1_sequence.txt.gz"],
    "CMS-105" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-105_1_sequence.txt.gz"],
    "CMS-106" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-106_1_sequence.txt.gz"],
    "CMS-107" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-107_1_sequence.txt.gz"],
    "CMS-108" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-108_1_sequence.txt.gz"],
    "CMS-109" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-109_1_sequence.txt.gz"],
    "CMS-110" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-110_1_sequence.txt.gz"],
    "CMS-111" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-111_1_sequence.txt.gz"],
    "CMS-112" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-112_1_sequence.txt.gz"],
    "CMS-113" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-113_1_sequence.txt.gz"],
    "CMS-114" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-114_1_sequence.txt.gz"],
    "CMS-115" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-115_1_sequence.txt.gz"],
    "CMS-116" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-116_1_sequence.txt.gz"],
    "CMS-117" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-117_1_sequence.txt.gz"],
    "CMS-118" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-118_1_sequence.txt.gz"],
    "CMS-119" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-119_1_sequence.txt.gz"],
    "CMS-120" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-120_1_sequence.txt.gz"],
    "CMS-121" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-121_1_sequence.txt.gz"],
    "CMS-122" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-122_1_sequence.txt.gz"],
    "CMS-123" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-123_1_sequence.txt.gz"],
    "CMS-124" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-124_1_sequence.txt.gz"],
    "CMS-125" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-125_1_sequence.txt.gz"],
    "CMS-126" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-126_1_sequence.txt.gz"],
    "CMS-127" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-127_1_sequence.txt.gz"],
    "CMS-128" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-128_1_sequence.txt.gz"],
    "CMS-129" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-129_1_sequence.txt.gz"],
    "CMS-130" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-130_1_sequence.txt.gz"],
    "CMS-131" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-131_1_sequence.txt.gz"],
    "CMS-132" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-132_1_sequence.txt.gz"],
    "CMS-133" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-133_1_sequence.txt.gz"],
    "CMS-134" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-134_1_sequence.txt.gz"],
    "CMS-135" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-135_1_sequence.txt.gz"],
    "CMS-136" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-136_1_sequence.txt.gz"],
    "CMS-137" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-137_1_sequence.txt.gz"],
    "CMS-138" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-138_1_sequence.txt.gz"],
    "CMS-139" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-139_1_sequence.txt.gz"],
    "CMS-140" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-140_1_sequence.txt.gz"],
    "CMS-141" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-141_1_sequence.txt.gz"],
    "CMS-142" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-142_1_sequence.txt.gz"],
    "CMS-143" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-143_1_sequence.txt.gz"],
    "CMS-144" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-144_1_sequence.txt.gz"],
    "CMS-145" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-145_1_sequence.txt.gz"],
    "CMS-146" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-146_1_sequence.txt.gz"],
    "CMS-147" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-147_1_sequence.txt.gz"],
    "CMS-148" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-148_1_sequence.txt.gz"],
    "CMS-149" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-149_1_sequence.txt.gz"],
    "CMS-150" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-150_1_sequence.txt.gz"],
    "CMS-151" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-151_1_sequence.txt.gz"],
    "CMS-152" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-152_1_sequence.txt.gz"],
    "CMS-153" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-153_1_sequence.txt.gz"],
    "CMS-154" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-154_1_sequence.txt.gz"],
    "CMS-155" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-155_1_sequence.txt.gz"],
    "CMS-156" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-156_1_sequence.txt.gz"],
    "CMS-157" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-157_1_sequence.txt.gz"],
    "CMS-158" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-158_1_sequence.txt.gz"],
    "CMS-159" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-159_1_sequence.txt.gz"],
    "CMS-160" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-160_1_sequence.txt.gz"],
    "CMS-161" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-161_1_sequence.txt.gz"],
    "CMS-162" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-162_1_sequence.txt.gz"],
    "CMS-163" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-163_1_sequence.txt.gz"],
    "CMS-164" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-164_1_sequence.txt.gz"],
    "CMS-165" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-165_1_sequence.txt.gz"],
    "CMS-166" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-166_1_sequence.txt.gz"],
    "CMS-167" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-167_1_sequence.txt.gz"],
    "CMS-168" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-168_1_sequence.txt.gz"],
    "CMS-169" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-169_1_sequence.txt.gz"],
    "CMS-170" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-170_1_sequence.txt.gz"],
    "CMS-171" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-171_1_sequence.txt.gz"],
    "CMS-172" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-172_1_sequence.txt.gz"],
    "CMS-173" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-173_1_sequence.txt.gz"],
    "CMS-174" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-174_1_sequence.txt.gz"],
    "CMS-175" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-175_1_sequence.txt.gz"],
    "CMS-176" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-176_1_sequence.txt.gz"],
    "CMS-177" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-177_1_sequence.txt.gz"],
    "CMS-178" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-178_1_sequence.txt.gz"],
    "CMS-179" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-179_1_sequence.txt.gz"],
    "CMS-180" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-180_1_sequence.txt.gz"],
    "CMS-181" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-181_1_sequence.txt.gz"],
    "CMS-182" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-182_1_sequence.txt.gz"],
    "CMS-183" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-183_1_sequence.txt.gz"],
    "CMS-184" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-184_1_sequence.txt.gz"],
    "CMS-185" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-185_1_sequence.txt.gz"],
    "CMS-186" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-186_1_sequence.txt.gz"],
    "CMS-187" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-187_1_sequence.txt.gz"],
    "CMS-188" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-188_1_sequence.txt.gz"],
    "CMS-189" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-189_1_sequence.txt.gz"],
    "CMS-190" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-190_1_sequence.txt.gz"],
    "CMS-191" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-191_1_sequence.txt.gz"],
    "CMS-192" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-192_1_sequence.txt.gz"],
    "CMS-193" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-193_1_sequence.txt.gz"],
    "CMS-194" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-194_1_sequence.txt.gz"],
    "CMS-195" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-195_1_sequence.txt.gz"],
    "CMS-196" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-196_1_sequence.txt.gz"],
    "CMS-197" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-197_1_sequence.txt.gz"],
    "CMS-198" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-198_1_sequence.txt.gz"],
    "CMS-199" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-199_1_sequence.txt.gz"],
    "CMS-200" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-200_1_sequence.txt.gz"],
    "CMS-201" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-201_1_sequence.txt.gz"],
    "CMS-202" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-202_1_sequence.txt.gz"],
    "CMS-203" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-203_1_sequence.txt.gz"],
    "CMS-204" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-204_1_sequence.txt.gz"],
    "CMS-205" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-205_1_sequence.txt.gz"],
    "CMS-206" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-206_1_sequence.txt.gz"],
    "CMS-207" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-207_1_sequence.txt.gz"],
    "CMS-208" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-208_1_sequence.txt.gz"],
    "CMS-209" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-209_1_sequence.txt.gz"],
    "CMS-210" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-210_1_sequence.txt.gz"],
    "CMS-211" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-211_1_sequence.txt.gz"],
    "CMS-212" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-212_1_sequence.txt.gz"],
    "CMS-213" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-213_1_sequence.txt.gz"],
    "CMS-214" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-214_1_sequence.txt.gz"],
    "CMS-215" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-215_1_sequence.txt.gz"],
    "CMS-216" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-216_1_sequence.txt.gz"],
    "CMS-217" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-217_1_sequence.txt.gz"],
    "CMS-218" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-218_1_sequence.txt.gz"],
    "CMS-219" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-219_1_sequence.txt.gz"],
    "CMS-220" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-220_1_sequence.txt.gz"],
    "CMS-221" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-221_1_sequence.txt.gz"],
    "CMS-222" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-222_1_sequence.txt.gz"],
    "CMS-223" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-223_1_sequence.txt.gz"],
    "CMS-224" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-224_1_sequence.txt.gz"],
    "CMS-225" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-225_1_sequence.txt.gz"],
    "CMS-226" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-226_1_sequence.txt.gz"],
    "CMS-227" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-227_1_sequence.txt.gz"],
    "CMS-228" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-228_1_sequence.txt.gz"],
    "CMS-229" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-229_1_sequence.txt.gz"],
    "CMS-230" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-230_1_sequence.txt.gz"],
    "CMS-231" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-231_1_sequence.txt.gz"],
    "CMS-232" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-232_1_sequence.txt.gz"],
    "CMS-233" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-233_1_sequence.txt.gz"],
    "CMS-234" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-234_1_sequence.txt.gz"],
    "CMS-235" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-235_1_sequence.txt.gz"],
    "CMS-236" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-236_1_sequence.txt.gz"],
    "CMS-237" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-237_1_sequence.txt.gz"],
    "CMS-238" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-238_1_sequence.txt.gz"],
    "CMS-239" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-239_1_sequence.txt.gz"],
    "CMS-240" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-240_1_sequence.txt.gz"],
    "CMS-241" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-241_1_sequence.txt.gz"],
    "CMS-242" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-242_1_sequence.txt.gz"],
    "CMS-243" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-243_1_sequence.txt.gz"],
    "CMS-244" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-244_1_sequence.txt.gz"],
    "CMS-245" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-245_1_sequence.txt.gz"],
    "CMS-246" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-246_1_sequence.txt.gz"],
    "CMS-247" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-247_1_sequence.txt.gz"],
    "CMS-248" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-248_1_sequence.txt.gz"],
    "CMS-249" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-249_1_sequence.txt.gz"],
    "CMS-250" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-250_1_sequence.txt.gz"],
    "CMS-251" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-251_1_sequence.txt.gz"],
    "CMS-252" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-252_1_sequence.txt.gz"],
    "CMS-253" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-253_1_sequence.txt.gz"],
    "CMS-254" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-254_1_sequence.txt.gz"],
    "CMS-255" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-255_1_sequence.txt.gz"],
    "CMS-256" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-256_1_sequence.txt.gz"],
    "CMS-257" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-257_1_sequence.txt.gz"],
    "CMS-258" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-258_1_sequence.txt.gz"],
    "CMS-259" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-259_1_sequence.txt.gz"],
    "CMS-260" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-260_1_sequence.txt.gz"],
    "CMS-261" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-261_1_sequence.txt.gz"],
    "CMS-262" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-262_1_sequence.txt.gz"],
    "CMS-263" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-263_1_sequence.txt.gz"],
    "CMS-264" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-264_1_sequence.txt.gz"],
    "CMS-265" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-265_1_sequence.txt.gz"],
    "CMS-266" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-266_1_sequence.txt.gz"],
    "CMS-267" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-267_1_sequence.txt.gz"],
    "CMS-268" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-268_1_sequence.txt.gz"],

    #"CMS-269" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-269_1_sequence.txt.gz"],
    #"CMS-270" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-270_1_sequence.txt.gz"],
    "CMS-271" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-271_1_sequence.txt.gz"],
    "CMS-272" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-272_1_sequence.txt.gz"],
    "CMS-273" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-273_1_sequence.txt.gz"],
    "CMS-274" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-274_1_sequence.txt.gz"],
    "CMS-275" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-275_1_sequence.txt.gz"],
    "CMS-276" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-276_1_sequence.txt.gz"],
    "CMS-277" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-277_1_sequence.txt.gz"],
    "CMS-278" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-278_1_sequence.txt.gz"],
    "CMS-279" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-279_1_sequence.txt.gz"],
    "CMS-280" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-280_1_sequence.txt.gz"],
    "CMS-281" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-281_1_sequence.txt.gz"],
    "CMS-282" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-282_1_sequence.txt.gz"],
    "CMS-283" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-283_1_sequence.txt.gz"],
    "CMS-284" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-284_1_sequence.txt.gz"],
    "CMS-285" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-285_1_sequence.txt.gz"],
    "CMS-286" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-286_1_sequence.txt.gz"],
    "CMS-287" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-287_1_sequence.txt.gz"],
    "CMS-288" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-288_1_sequence.txt.gz"],
    "CMS-289" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-289_1_sequence.txt.gz"],
    "CMS-290" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-290_1_sequence.txt.gz"],
    "CMS-291" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-291_1_sequence.txt.gz"],
    "CMS-292" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-292_1_sequence.txt.gz"],
    "CMS-293" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-293_1_sequence.txt.gz"],
    "CMS-294" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-294_1_sequence.txt.gz"],

    #"CMS-295" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-295_1_sequence.txt.gz"],
    "CMS-296" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-296_1_sequence.txt.gz"],
    "CMS-297" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-297_1_sequence.txt.gz"],
    "CMS-298" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-298_1_sequence.txt.gz"],
    "CMS-299" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-299_1_sequence.txt.gz"],
    "CMS-300" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-300_1_sequence.txt.gz"],
    "CMS-301" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-301_1_sequence.txt.gz"],
    "CMS-302" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-302_1_sequence.txt.gz"],
    "CMS-303" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-303_1_sequence.txt.gz"],
    "CMS-304" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-304_1_sequence.txt.gz"],
    "CMS-305" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-305_1_sequence.txt.gz"],
    "CMS-306" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-306_1_sequence.txt.gz"],
    "CMS-307" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-307_1_sequence.txt.gz"],
    "CMS-308" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-308_1_sequence.txt.gz"],
    "CMS-309" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-309_1_sequence.txt.gz"],
    "CMS-310" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-310_1_sequence.txt.gz"],
    "CMS-311" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-311_1_sequence.txt.gz"],
    "CMS-312" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-312_1_sequence.txt.gz"],
    "CMS-313" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-313_1_sequence.txt.gz"],
    "CMS-314" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-314_1_sequence.txt.gz"],
    "CMS-315" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-315_1_sequence.txt.gz"],
    "CMS-316" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-316_1_sequence.txt.gz"],
    "CMS-317" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-317_1_sequence.txt.gz"],
    "CMS-318" => ["/gpfs21/scratch/cqs/guoy1/2868/2868-CMS-318_1_sequence.txt.gz"],
  }
};

my $groups = {
  "RA" => [
    "CMS-025",    # "CMS-052",
    "CMS-026",    # "CMS-053",
    "CMS-027",    # "CMS-057",
    "CMS-028",    # "CMS-058",
    "CMS-029",    # "CMS-060",
    "CMS-030",    # "CMS-061",
    "CMS-054",    # "CMS-310",
    "CMS-056",    # "CMS-312",
    "CMS-062",    # "CMS-314",
    "CMS-082", "CMS-083", "CMS-084", "CMS-085", "CMS-086", "CMS-087", "CMS-088", "CMS-089",    #
    "CMS-090", "CMS-091", "CMS-092", "CMS-093", "CMS-094", "CMS-095", "CMS-096", "CMS-097",    #
    "CMS-106", "CMS-107", "CMS-108", "CMS-109",                                                                      #
    "CMS-110", "CMS-111", "CMS-112", "CMS-113", "CMS-114", "CMS-115", "CMS-116", "CMS-117", "CMS-118", "CMS-119",    #
    "CMS-120", "CMS-121",                                                                                            #
    "CMS-130", "CMS-131", "CMS-132", "CMS-133", "CMS-134", "CMS-135", "CMS-136", "CMS-137", "CMS-138", "CMS-139",    #
    "CMS-140", "CMS-141", "CMS-142", "CMS-143", "CMS-144", "CMS-145",                                                #
    "CMS-154", "CMS-155", "CMS-156", "CMS-157", "CMS-158", "CMS-159",                                                #
    "CMS-160", "CMS-161", "CMS-162", "CMS-163", "CMS-164", "CMS-165", "CMS-166", "CMS-167", "CMS-168", "CMS-169",    #
    "CMS-178", "CMS-179",                                                                                            #
    "CMS-180", "CMS-181", "CMS-182", "CMS-183", "CMS-184", "CMS-185", "CMS-186", "CMS-187", "CMS-188", "CMS-189",    #
    "CMS-190", "CMS-191", "CMS-192", "CMS-193",                                                                      #
    "CMS-202", "CMS-203", "CMS-204", "CMS-205", "CMS-206", "CMS-207", "CMS-208", "CMS-209",                          #
    "CMS-210", "CMS-211", "CMS-212", "CMS-213", "CMS-214", "CMS-215", "CMS-216", "CMS-217",                          #
    "CMS-226", "CMS-227", "CMS-228", "CMS-229",                                                                      #
    "CMS-230", "CMS-231", "CMS-232", "CMS-233", "CMS-234", "CMS-235", "CMS-236", "CMS-237", "CMS-238", "CMS-239",    #
    "CMS-240", "CMS-241",                                                                                            #
    "CMS-250", "CMS-251", "CMS-252", "CMS-253", "CMS-254", "CMS-255", "CMS-256", "CMS-257", "CMS-258", "CMS-259",    #
    "CMS-260", "CMS-261", "CMS-262", "CMS-263",                                                                      #
    "CMS-264",                                                                                                       # "CMS-055","CMS-311",
    "CMS-265",                                                                                                       #
    "CMS-274", "CMS-275", "CMS-276", "CMS-277", "CMS-278", "CMS-279",                                                #
    "CMS-280", "CMS-281", "CMS-282", "CMS-283", "CMS-284", "CMS-285", "CMS-286", "CMS-287", "CMS-288", "CMS-289",    #
    "CMS-290", "CMS-291", "CMS-292", "CMS-293", "CMS-294", "CMS-296", "CMS-297", "CMS-298", "CMS-299",               #
    "CMS-300", "CMS-301", "CMS-302",                                                                                 #
    "CMS-313",                                                                                                       # "CMS-059",
    "CMS-315"                                                                                                        # "CMS-063",

  ],
  "RAControl" => [
    "CMS-032",                                                                                                       # "CMS-068",
    "CMS-033",                                                                                                       # "CMS-069",
    "CMS-046", "CMS-047", "CMS-048", "CMS-049",                                                                      #
    "CMS-050", "CMS-051",                                                                                            #
    "CMS-064",                                                                                                       # "CMS-316",
    "CMS-065",                                                                                                       # "CMS-031"
    "CMS-066",                                                                                                       # "CMS-317",
    "CMS-067",                                                                                                       # "CMS-318"
    "CMS-070", "CMS-071", "CMS-072", "CMS-073", "CMS-074", "CMS-075", "CMS-076", "CMS-077", "CMS-078", "CMS-079",    #
    "CMS-080",                                                                                                       #
    "CMS-098", "CMS-099",                                                                                            #
    "CMS-100", "CMS-101", "CMS-102", "CMS-103", "CMS-104", "CMS-105",                                                #
    "CMS-122", "CMS-123", "CMS-124", "CMS-125", "CMS-126", "CMS-127", "CMS-128", "CMS-129",                          #
    "CMS-146", "CMS-147", "CMS-148", "CMS-149",                                                                      #
    "CMS-150", "CMS-151", "CMS-152", "CMS-153",                                                                      #
    "CMS-170", "CMS-171", "CMS-172", "CMS-173", "CMS-174", "CMS-175", "CMS-176", "CMS-177",                          #
    "CMS-194", "CMS-195", "CMS-196", "CMS-197", "CMS-198", "CMS-199",                                                #
    "CMS-200", "CMS-201",                                                                                            #
    "CMS-218", "CMS-219",                                                                                            #
    "CMS-220", "CMS-221", "CMS-222", "CMS-223", "CMS-224", "CMS-225",                                                #
    "CMS-242", "CMS-243", "CMS-244", "CMS-245", "CMS-246", "CMS-247", "CMS-248", "CMS-249",                          #
    "CMS-266", "CMS-267", "CMS-268",                                                                                 #
    "CMS-272", "CMS-273",                                                                                            #
    "CMS-303", "CMS-304", "CMS-305", "CMS-306", "CMS-307", "CMS-308",                                                #
    "CMS-309",                                                                                                       # "CMS-081"
                                                                                                                     #
  ],

  "SLE" => [
    "CMS-034", "CMS-035", "CMS-036", "CMS-037", "CMS-038", "CMS-039",                                                #
    "CMS-040", "CMS-041", "CMS-042", "CMS-043", "CMS-044", "CMS-045"
  ],
  "AltControl" => ["CMS-271"],
};

$def->{groups}         = $groups;
$def->{pairs}          = { "RA_vs_Control" => [ "RAControl", "RA" ] };
$def->{tRNA_vis_group} = $groups;
performSmallRNA_hg19($def);

1;

