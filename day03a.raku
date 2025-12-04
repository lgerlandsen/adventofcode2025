use v6;

my $filename = "day03.input";
 
my $totaljolt=0;

for $filename.IO.lines -> $line {
    my $n1=0;
    my $n2=0;
    for $line.split("") -> $number {
        if $n1==0 { $n1=$number; next;}
        if $n2==0 { $n2=$number; next;}
        if "$n1$n2" < "$n2$number"  { $n1=$n2; $n2=$number; next; }
        if "$n1$n2" < "$n1$number" { $n2=$number; next; }
    }
    my $jolt="$n1$n2";
#    say "$line=$jolt";
    $totaljolt+=$jolt;
}
say "Total joltage=$totaljolt"; 
