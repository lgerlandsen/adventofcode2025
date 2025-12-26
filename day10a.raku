use v6;
my $filename="day10.input";
my $line;



my @machine=[];
for $filename.IO.lines -> $line { 
    if $line ~~ /\[(.*)\].(.*).\{(.*)\}/ {
        my @light = $0.comb;
        my List $wiring = $1.split(" ").List;
        my List $joltage = $2.split(",").List;
#        say "{@light.raku} - {$wiring.raku} - {$joltage.raku}";
#        say @light[0];
        @machine.push([@light,$wiring,$joltage]);
#        say @machine;
    } else {
        say "Bad input line $line";
        exit;
    }
}

say @machine;

sub switchlight( @goal,  @l, List $wiring ) returns Int {
    my $presses = 0;
    #say "inside sub";
    #say "goal  {@goal}  l {@l} wiring $wiring wiring1 {$wiring[1]} presses $presses";
    
    my  $wl;
    
    my @newlights=[];
    my @lights=[];
    @lights.push(@l);
    until  $presses > 100 {
        $presses++;
        #say "presses $presses lights {@lights}";
        my @onelight;
        for @lights -> @onelight {
            for $wiring.Array -> $wl {
                my @newl=@onelight.clone;
                my @button = $wl.substr(1, $wl.chars - 2).split(",");
                my $w;
                for @button -> $w {
                    if @newl[$w] eq "#"  {
                        @newl[$w]=".";
                    } else {
                        @newl[$w]="#";
                    }
                }
#                say "old {@onelight} newl {@newl} goal {@goal}";
                @newlights.push(@newl);
                if @goal eqv @newl { 
                    return $presses;
                }
            }
        }
#        say @newlights;
        @lights = @newlights.clone;
        @newlights=[];
#        say " lights " ~ @lights ~ " newlights {@newlights}";

    }
    die "too many presses $presses";
}

my @m;
my $totalpresses = 0;
for @machine -> @m {
    my @l = @m[0];
    my List $w = @m[1];
    my List $j = @m[2];
#    say @l ~ " element 0 " ~ @l[0];
#    say $w;
#    say ("." x @l[0].elems);
    my Int $presses=0;
    $presses=switchlight(@l[0],("." x @l[0].elems).comb,$w);
    say "Machine with goal {@l} needs $presses presses.";
    $totalpresses += $presses;
}
say "Total presses $totalpresses";
