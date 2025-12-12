use v6;
my $filename="day09.input";
my $line;

my @coordinates=[];
for $filename.IO.lines -> $line { 
    @coordinates.push($line.split(","));
}

sub rectangle(@a, @b) {
    my $l =  @a[0]>@b[0] ?? @a[0]-@b[0]+1  !! @b[0]-@a[0]+1;
    my $b =  @a[1]>@b[1] ?? @a[1]-@b[1]+1  !! @b[1]-@a[1]+1;
    return $l * $b;
}

my $largestrectangle=0;
loop ( my $i=0 ; $i < @coordinates.elems ; $i++ ) {
    loop ( my $j=$i+1 ; $j < @coordinates.elems ; $j++ ) {
        #say $count++ ~ " ($i,$j) @boxes[$i] @boxes[$j] " ~ euclidean-distance(@boxes[$i], @boxes[$j]);
        my $size = rectangle(@coordinates[$i],@coordinates[$j]);
        if $size > $largestrectangle {$largestrectangle = $size;}
    }
}
say "Største rektangel $largestrectangle";
