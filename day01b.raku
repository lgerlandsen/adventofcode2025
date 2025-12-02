use v6;

my $filename = "day01a.input";

my $value=50;
my $direction;
my $steps;
my $line;
my $count=0;
my $oldvalue;

for $filename.IO.lines -> $line {
  if $line ~~ /([L|R])(\d+)/ {
    $direction=$0;
    $steps=$1;
    $oldvalue = $value;
    if $steps > 100 { 
        $count = $count + $steps div 100;
        $steps = $steps % 100;
    }
    if $direction eq "R" {
        $value += $steps;
    } elsif $direction eq "L" {
        $value -= $steps;
    } else { say "wrong direction $direction"; }
    #say "$line old $oldvalue step $steps ny $value";
    if $value < 0 {
        $value = 100 + $value;
        if $oldvalue != 0 { $count++; }
        #say "added to count <";
    } elsif $value > 99 {
        $value = $value - 100;
        if $oldvalue != 0 { $count++; }
        #say "added to count >";
    } elsif $value == 0 {
        $count++;
        #say "added to count =";
    }
}
}
say $count;