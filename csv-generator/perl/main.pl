#!/usr/bin/env perl

use strict;
use warnings;

srand(100);
print "create_timestamp,player_id,score\n";
for my $i (0..100000000) {
  my $player_id = rand(10000);
  my $score = rand(10000);
  printf("2022-06-13 12:00,player%d,%d\n", $player_id, $score);
}
