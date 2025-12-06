use v6;

my $filename="day05.input";
my $count=0;
my @intervals;
my $line;
my $firsthalf=True;
for $filename.IO.lines -> $line {
    if $firsthalf {
        if $line ne "" {
            my ($a,$b)= $line.split("-");
            @intervals.push([$a,  $b]);
        } else {
            $firsthalf=False;
        }
    } else {
        my $spoiled=True;
        my $list;
        for @intervals -> @list {
            if @list[0] <= $line &&  @list[1] >= $line {
                $spoiled=False;
                $count++;
            }
            last if !$spoiled;
        }
        #if $spoiled {say "$line is spoiled"} else {say "$line is fresh"};
    }
}

say "$count ingredients are fresh";

