#!/usr/bin/perl -w
# a script to merge at least two xyz files into one big one
# V. Kairys, Life Sciences Center at  Vilnius University
#

use strict;
use warnings;

die "Usage: $0 file1.xyz file2.xyz ...  > mergedfile.xyz (or to strandard output if the merged file name is not specified)\n" if(@ARGV==0);


print STDERR "input files: ";
foreach my $file ( @ARGV ){
    print STDERR "$file ";
}
print STDERR "\n";

my $infoline="";
my $totatoms=0;
foreach my $file (@ARGV){
    open(MOLF,"<$file") or die "Error while opening $file $!\n";
    while(<MOLF>){
        if($. == 1){
            chomp; my @tmp=split;
            print STDERR "file $file, number of atoms $tmp[0]\n";
            $totatoms += $tmp[0];
            $infoline .="$file ";
        }
    }
    close(MOLF);
}
print STDERR "total number of atoms $totatoms\n";
print STDERR "infoline $infoline\n";
print STDERR "printing into the standard output the merged molecule\n";
print "$totatoms\n";
print "$infoline\n";
foreach my $file (@ARGV){
    open(MOLF,"<$file") or die "Error while opening $file $!\n";
    while(<MOLF>){
        next if($. == 1);
        next if($. == 2);
        print $_;
    }
    close(MOLF);
}
