use v6;

my $filename = "day03.input";
 
my $totaljolt=0;

for $filename.IO.lines -> $line {
    my $bank=substr($line,0,12);
    my $restline = substr($line,12);
    my $n;
    for $restline.split("") -> $n {
        my $r;
        my $high = $bank;
        my $newbank;
        loop ( my $i=0; $i < 12; $i++ ) {
            if $i == 0  {
                $newbank="$bank.substr($i+1)$n";
            } elsif $i < 11 {
                $newbank="$bank.substr(0,$i)$bank.substr($i+1)$n";
            } else {
                $newbank="$bank.substr(0,$i)$n";
            }
            if $newbank > $high {
                $high = $newbank;
            }
        }
        $bank=$high;
    }
    $totaljolt+=$bank;
}
say "Total joltage=$totaljolt";
