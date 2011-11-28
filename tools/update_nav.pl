#!/usr/bin/perl -w

use warnings;
use strict;

use File::Basename;
use Data::Dumper qw(Dumper);
use FindBin qw($Bin);

my $category = shift;
my $dir = $Bin.'/../'.$category.'/_posts/';
if ( !-d $dir ) {
    die "Category '$category' not exists!\n";
}

my @files = glob("$dir/*.md");
my @sort_files;
for my $file( @files ) {
    my $name = basename($file);
    if ( $name =~ /\d+-\d+-\d+-(\d+)(.*)\.md/ ) {
        $sort_files[$1] = [$1.$2.'.html', $file];
    }
}

for my $i( 1..$#sort_files ) {
    my $prev = ($i>1 ? '<a href="'.$sort_files[$i-1][0].'">Previous</a>' : '&nbsp;');
    my $next = ($i<$#sort_files ? '<a href="'.$sort_files[$i+1][0].'">Next</a>' : '&nbsp');
    my $file = $sort_files[$i][1];
    
    open(my $fh, "<", $file) or die "Can't open file $file: $!";
    open(my $out, ">", $file.'.bak') or die "Can't create file: $!";
    while ( <$fh> ) {
        if ( /<ul class="post-nav/) {
            print {$out} <<EOF;
<ul class="post-nav clearfix">
<li class="prev">$prev</li>
<li class="top"><a href="/$category/">Top</a><li>
<li class="next">$next<li>
</ul>
EOF
            last;
        }
        print {$out} $_;
    }
    close($out);
    rename($file.'.bak', $file);
}
