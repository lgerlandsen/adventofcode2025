use v6;

my $filename = "day01a.input";

my $value=50;
my $direction;
my $steps;
my $line;
my $count=0;

for $filename.IO.lines -> $line {
  if $line ~~ /([L|R])(\d+)/ {
    $direction=$0;
    $steps=$1;
    if $steps > 100 { $steps = $steps % 100; }
    if $direction eq "R" {
        $value += $steps;
    } elsif $direction eq "L" {
        $value -= $steps;
    } else { say "wrong direction $direction"; }
    if $value < 0 {
        $value = 100 + $value;
    } elsif $value > 99 {
        $value = $value - 100;
    } 
    #say "direction $direction with $steps steps, new value $value";
    if $value == 0 { $count++ ; }
}
}
say $count; # answer 1059
