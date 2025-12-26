
use v6;

# how to use glpsol from https://github.com/54skyxenon/AOC-2025/blob/main/day10.pl

my $filename="day10.input";
my $line;
my @lines=[];

for $filename.IO.lines -> $line { 
    @lines.push($line);
}



sub fewest_presses_joltage(Str $line) {
    my @tokens = $line.split(' ');
    my @buttons = @tokens[1 .. @tokens.elems - 2];
    my @joltages = @tokens[*-1].substr(1,*-1).split(',');
    my @vars = (1 .. @buttons.elems).map({"x$_"}); 
    
    my @constraints_lhs = (1 .. @joltages.elems).map({[]});
    for (1 .. @buttons.elems) -> $i {
        my @button_digits = @buttons[$i - 1].substr(1, *-1).split(',');
        my $digit;
        for  @button_digits -> $digit {
            @constraints_lhs[$digit].push("x$i");
        }
    }
    
    # Solve ILP problem with glpsol (since Perl doesn't have maintained package)
    my @constraints;
    for ( 0 .. @joltages.elems - 1) -> $j {
        my $lhs = @constraints_lhs[$j].join( " + " );
        my $rhs = @joltages[$j];
        @constraints.push("$lhs = $rhs");
    }

    # https://web.mit.edu/lpsolve/doc/CPLEX-format.htm
    my $objective_fn = @vars.join(" + ");    
    my $lp = "Minimize\n  obj: $objective_fn\n\n";
    
    $lp = $lp ~ "Subject To\n";
    my $k = 1;
    for @constraints -> $c {
        $lp = $lp ~ "  c$k: $c\n";
        $k++;
    }

    $lp =$lp ~ "\nBounds\n";
    for @vars ->  $v {
        $lp = $lp ~ "  $v >= 0\n";
    }

    # This section makes them ints
    my $general_section = @vars.join(" ");
    $lp = $lp ~ "\nGeneral\n  $general_section\n\nEnd\n";

    my  $fh = open "problem.txt", :w;
    $fh.say($lp);
    $fh.close;
    my $sol = qx{glpsol.exe --lp --write /dev/stdout problem.txt};

    my $ans=0;
    if $sol ~~ /Objective\:\s+\S+\s+\=\s+(\S+)/ {
        $ans = $0;
    }
    print "Answer $ans\n";
    return $ans;
}

sub part_2(@lines) {
    return @lines.map( &fewest_presses_joltage ).sum;
}

print(part_2(@lines) ~ "\n"); # 15017
