use v6;

my $filename = "day04.input";
my @room;
my $line;
for $filename.IO.lines -> $line {  
    @room.append: ".$line.";
}

my $dots = '.' x @room[0].chars;
@room.append: $dots;
@room.unshift: $dots;

my $count=0;

loop ( my $i=1; $i < @room.elems - 1 ; $i++) {
    my $l1 =  @room[$i];
    loop ( my $j=1; $j < $l1.chars - 1 ; $j++ ) {
        if $l1.substr($j,1) eq "@" {
            my $t="@room[$i-1].substr($j-1,3)";
            $t="$t@room[$i].substr($j-1,3)";
            $t="$t@room[$i+1].substr($j-1,3)";
            if comb("@",$t).elems < 5 { 
                $count++;
            }
        }
    }
}
say "Free paper rolls $count";
