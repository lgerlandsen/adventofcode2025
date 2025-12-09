use v6;
use Math::DistanceFunctions;

my $filename="day08.input";
my $line;
my @boxes;
for $filename.IO.lines -> $line {
    my @b = $line.split(",")>>.Num; 
    @boxes.push([@b]);
}
say "Antall bokser " ~ @boxes.elems;
my $i;
my $j;
my $count=0;

my @connections;
loop ( $i=0 ; $i < @boxes.elems ; $i++ ) {
    loop ( $j=$i+1 ; $j < @boxes.elems ; $j++ ) {
        #say $count++ ~ " ($i,$j) @boxes[$i] @boxes[$j] " ~ euclidean-distance(@boxes[$i], @boxes[$j]);
        @connections.push([$i, $j, euclidean-distance(@boxes[$i], @boxes[$j])]);
    }
}
say "Antall connections " ~ @connections.elems;


my @sorted = @connections.sort( -> @a, @b {
    @a[2] <=> @b[2];
});

say "Sorted";

my @circuits=[];
my $inserted=False;
my $lastinserted;

loop ( $i = 0; $i < @sorted.elems ; $i++ ) {
    $count++;
    if $count % 10000 == 0 { print "."; } 
    my $a=@sorted[$i][0];
    my $b=@sorted[$i][1];
    $inserted=-1;
    # trenger å rydde og effektivisere
    loop ( $j=0 ; $j < @circuits.elems ; $j++ ) {
        if ($a) (elem) @circuits[$j].cache && ($b) (elem) @circuits[$j].cache { 
            $inserted = $j;
            last;
            # both already inserted
        } elsif $inserted < 0 &&  ($a) (elem) @circuits[$j] {
            $lastinserted=$i;
            @circuits[$j] = (@circuits[$j], $b)>>.List.flat;
            $inserted=$j;
        } elsif $inserted < 0 &&  ($b) (elem) @circuits[$j]  {
            $lastinserted=$i;
            @circuits[$j] = (@circuits[$j], $a )>>.List.flat;
            $inserted=$j;
        } elsif $inserted >= 0 && (($a) (elem) @circuits[$j] || ($b) (elem) @circuits[$j]) {
            @circuits[$inserted] = ( @circuits[$inserted], @circuits[$j] )>>.List.flat.unique;
            @circuits.splice($j,1);
            # trekk fra en siden neste nå er en mindre enn den var
            $j--
        }
    }
    if $inserted < 0 {
        @circuits.push(($a, $b));
    }
}
say @circuits;
say "$lastinserted = " ~ @sorted[$lastinserted] ~ 
    " - " ~ @boxes[@sorted[$lastinserted][0]] ~ 
    " - " ~ @boxes[@sorted[$lastinserted][1]];

say "answer=" ~ @boxes[@sorted[$lastinserted][0]][0] * @boxes[@sorted[$lastinserted][1]][0];
