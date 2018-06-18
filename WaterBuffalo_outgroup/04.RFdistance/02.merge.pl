#! /usr/bin/env perl
use strict;
use warnings;

my %hash;
open I1,"< prob.txt";
<I1>;
open I2,"< 01.RF_distance.pl.dist";
<I2>;
while (my $l1=<I1>) {
    my $l2=<I2>;
    chomp $l1;
    chomp $l2;
    my @a1=split(/\s+/,$l1);
    my @a2=split(/\s+/,$l2);
    my ($tree,$observed,$nuclear_exp,$mt_exp)=@a1;
    my $x=$a2[1]-$a2[0];
    my $type;
    if($x>0){
        $type="0.ntLike";
    }
    elsif ($x==0) {
        $type="1.none";
    }
    elsif ($x<0) {
        $type="2.mtLike";
    }
    $hash{$type}{$tree}{total}=$observed+$nuclear_exp;
    $hash{$type}{$tree}{observed}=$observed;
    $hash{$type}{$tree}{nuclear_exp}=$nuclear_exp;
    $hash{$type}{$tree}{mt_exp}=$mt_exp;
}
close I1;
close I2;

my $no=0;
open O,"> $0.out";
open O2,"> $0.barplot";
print O "no\ttype\ttree\tobserved\tnuclear_exp\tmt_exp\n";
print O2 "no\tcategory\ttree\ttype\tfreq\n";
foreach my $type(sort keys %hash){
    foreach my $tree(sort {$hash{$type}{$b}{total}<=>$hash{$type}{$a}{total}} keys %{$hash{$type}}){
        $no++;
        print O "$no\t$type\t$tree\t$hash{$type}{$tree}{observed}\t$hash{$type}{$tree}{nuclear_exp}\t$hash{$type}{$tree}{mt_exp}\n";
        $hash{$type}{$tree}{nuclear_exp}*=-1;
        print O2 "$no\t$type\t$tree\tobserved\t$hash{$type}{$tree}{observed}\n";
        print O2 "$no\t$type\t$tree\tsimulate\t$hash{$type}{$tree}{nuclear_exp}\n";
    }
}
close O;
close O2;
