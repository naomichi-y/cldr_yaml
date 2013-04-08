#!/usr/bin/perl

use strict;
use warnings;

use File::Spec;
use File::Basename;
use XML::Simple;
use YAML::Syck;

my $absolutePath = dirname(File::Spec->rel2abs($0)) . '/../';
my $sourcePath = $absolutePath . 'vendors/cldr/core/common/main';

$YAML::Syck::Headless = 1;

opendir(DIR_HANDLE, $sourcePath);

foreach (readdir(DIR_HANDLE)) {
  if ($_ eq '.' || $_ eq '..') {
    next;
  }

  my $targetPath = $sourcePath . '/' . $_;
  my $xml = XMLin($targetPath);
  my $yaml = Dump($xml);

  my $writePath = $absolutePath . '/dest/common/main/' . $_;

  open(OUT_HANDLE,">" . $writePath);
  print OUT_HANDLE $yaml;
  close(OUT_HANDLE);

  printf sprintf("converted dest/common/main/%s\n", $_);
}

closedir(DIR_HANDLE);

