use v6;

my $filename="day05.input";
my @intervals=[];
my $line;
for $filename.IO.lines -> $line {
    last if $line eq ""; 
    my ($a,$b)= $line.split("-");
    @intervals.push([$a , $b]);
}
#say @intervals;
my @sorted = @intervals.sort( { .[0].Int, .[1].Int } );
#say @sorted;
my @interval;
my $count=0;
my $largest=-1;
for @sorted -> @interval {
    #say @interval;
    my $a;
    my $b;
    $a=@interval[0];
    $b=@interval[1];
    if $largest >= $a {
        if $largest < $b {
            $count += $b - $largest;
            $largest=$b;
        }
    } else {
        $count += $b - $a +1;
        $largest = $b;
    }
}
say "Total count id numbers = $count";