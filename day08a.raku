use v6;
use Math::DistanceFunctions;

my $filename="day08.input";
my $boxestoconnect=1000;
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

my @circuits=[];
my $inserted=False;
loop ( $i = 0; $i < $boxestoconnect ; $i++ ) {
    my $a=@sorted[$i][0];
    my $b=@sorted[$i][1];
    $inserted=-1;
    my $circuit;
    loop ( $j=0 ; $j < @circuits.elems ; $j++ ) {
        my @circuit=@circuits[$j].cache;
        @circuit=@circuit>>.List.flat;
        if ($a) (elem) @circuit || ($b) (elem) @circuit {
            if $inserted < 0 {
                @circuits[$j] = (@circuit, $a, $b)>>.List.flat.unique;
                $inserted=$j;
            } else {
                @circuits[$inserted] = ( @circuits[$inserted], @circuits[$j] )>>.List.flat.unique;
                @circuits[$j]=();
            }
        }
    }
    if $inserted < 0 {
        @circuits.push(($a, $b));
    }
}
#say @circuits;

my @sortedcircuits = @circuits.sort( -> @a, @b {
    @b.elems <=> @a.elems;
});
#say @sortedcircuits;

say "Size " ~ @sortedcircuits[0].elems * @sortedcircuits[1].elems * @sortedcircuits[2].elems ;
