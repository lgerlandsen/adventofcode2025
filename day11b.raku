use v6;
use Memoize;
memoize(&findpath);

my $filename="day11.input";
my $line;
my %lines;

for $filename.IO.lines -> $line { 
    my ($key,$valuestring) = $line.split(":");
    my @values = $valuestring.trim.split(" ");
    %lines{$key} = @values;
}





sub findpath( $output, $foundfft, $founddac ) {
    my $f=$foundfft;
    my $d=$founddac;
        if $output eq "out" {
            if $foundfft and $founddac {
                return 1;
            } else {
                return 0;
            }
        } else {
            if $output eq "fft" { $f = True; }
            elsif $output eq "dac" { $d = True; }
            return %lines{$output}.map( -> $value { findpath($value , $foundfft || $value eq "fft", $founddac || $value eq "dac") } ).sum
        }
}
my $result = %lines{"svr"}.map( -> $value {findpath($value , False, False)}).sum;

say "Total possible paths = $result";
