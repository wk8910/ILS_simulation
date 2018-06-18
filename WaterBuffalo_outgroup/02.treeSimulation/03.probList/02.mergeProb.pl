#! /usr/bin/env perl
use strict;
use warnings;

# my @prob=@ARGV;
my @prob=("observed.prob","nuclear.prob","mt.prob");
my $out="prob.txt";

my %hash;
my %count;

my @type;
foreach my $prob(@prob){
    open I,"< $prob";
    $prob=~/^([^.]+)/;
    my $type=$1;
    push @type,$type;
    while (<I>) {
        chomp;
        my @a=split(/\s+/);
        my ($tre,$count,$percent)=@a;
        # next unless($percent > 0.001);
        $hash{$tre}{$type}{count}=$count;
        $hash{$tre}{$type}{percent}=$percent;
        $count{$tre}+=$percent;
    }
    close I;
}

open O,"> $out";
# print O "tree\tobserved\tsimulate\n";
my @head=("topology");
push @head,@type;
print O (join "\t",@head),"\n";
foreach my $tre(sort {$count{$b}<=>$count{$a}} keys %count){
    my @line=($tre);
    foreach my $type(@type){
        my $percent=0;
        if(exists $hash{$tre}{$type}{percent}){
            $percent=$hash{$tre}{$type}{percent};
        }
        push @line,$percent;
    }
    print O (join "\t",@line),"\n";
}
close O;
