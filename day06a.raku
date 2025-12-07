use v6;

my $filename="day06.input";
my @rows=[];
my $line;
for $filename.IO.lines -> $line {
    my @l1= $line.words;
    @rows.push([@l1]);
}

my $numberofrows=@rows.elems;
my $numberofcolumns=@rows[0].elems;
my $totalresult=0;
loop ( my $i=0; $i < $numberofcolumns; $i++) {
    my $o = @rows[$numberofrows-1][$i];
    my $columnresult;
    if $o eq "+" { $columnresult=0;} else {$columnresult=1;}
    loop ( my $j=0; $j < $numberofrows - 1 ; $j++) {
        if $o eq "+" {
            $columnresult += @rows[$j][$i];
        } else {
            $columnresult *= @rows[$j][$i];
        }
    }
    #say $columnresult;
    $totalresult += $columnresult;
}
say "Total result $totalresult";
