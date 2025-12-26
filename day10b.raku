use v6;
my $filename="day10.input";
my $line;



my @machine=[];
for $filename.IO.lines -> $line { 
    if $line ~~ /\[(.*)\].(.*).\{(.*)\}/ {
        my @light = $0.comb;
        my List $wiring = $1.split(" ").List;
        my List $joltage = $2.split(",").List;
        @machine.push([@light,$wiring,$joltage]);
    } else {
        say "Bad input line $line";
        exit;
    }
}

#say @machine;

sub addjoltage( Int @goal, Int @j, List $wiring ) returns Int {
    #say "goal {@goal} new {@j} wiring $wiring";
    my $presses = 0;
    my $wl;
    my @newjoltages is Array of Array[Int];
    my @joltages is Array of Array[Int];
    @joltages.push(@j);
    until  $presses > 1000 {
        $presses++;
        my @joltage;
        for @joltages -> @joltage {
            my @buttonstoremove=[];
            for $wiring.Array -> $wl {
                my Int @newj=@joltage.clone;
                #say "newj {@newj.raku} joltage {@joltage.raku}";
                my @button = $wl.substr(1, $wl.chars - 2).split(",");
                my $w;
                my $add=-True;
                for @button -> $w {
                    @newj[$w] = @newj[$w] + 1;
                    if @newj[$w] > @goal[$w] { 
                        $add = False;
                        last;
                    }
                }
                #say "goal {@goal} newj {@newj}";
                if $add {
                    @newjoltages.push(@newj);
                    if @goal eqv @newj { 
                        return $presses;
                    }
                }
            }
        }
        #say "Pressed $presses";
        say "array elements {@newjoltages.elems}";
        @joltages = @newjoltages.clone;
        @newjoltages=[];
    }
    die "too many presses $presses";
}

my @m;
my $totalpresses = 0;
for @machine -> @m {
    #say @m;
    my @j;
    @j = @m[2];
    my List $w = @m[1];
    my Int $presses=0;
    my Int @newj ;
    @newj = 0 xx @j[0].elems;
    #say "goal {@j} zeroes {@newj} wiring $w";
    my Int @j0;
    my List $integers;
    my Int $i;
    $integers = @j[0];
    #say @newj.raku;
    #say @j.raku;
    #say $integers[0];
    loop ( my $j = 0 ; $j < $integers.elems; $j++) {
        @j0.push(+$integers[$j]);
    }
    $presses=addjoltage(@j0,@newj,$w);
    say "Machine with goal {@j0} needs $presses presses.";
    $totalpresses += $presses;
}
say "Total presses $totalpresses";
