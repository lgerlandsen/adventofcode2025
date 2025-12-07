use v6;

my $filename="day06.input";
my @rows=[];
my $line;
for $filename.IO.lines -> $line {
    @rows.push([$line]);
}

my @columns;

loop ( my $i=0 ; $i < @rows[0].chars ; $i++ ) {
    my $row="";
    loop (my $j=0; $j < @rows.elems ; $j++) {
        $row = $row ~ @rows[$j].substr($i,1);
    }
    @columns.push($row);
}
my $totalcount=0;
my $count=0;
my $previousrow="";
my $o;
for @columns -> $row {
    if $previousrow eq "" {
        $previousrow = "w";
        $o=$row.substr($row.chars -1 , 1);
        if $o eq "+" { $count=0; } else { $count=1;}
    }
    if $row.trim ne "" {
        if $o eq "+" { 
            $count += $row.substr(0,$row.chars-1);
        } else { 
            $count *= $row.substr(0,$row.chars-1);
        }
    } elsif $row.trim eq "" {
        $previousrow = "";
        $totalcount += $count;
        $count = 0;
    }
}
$totalcount += $count;
say "Total count $totalcount";