use v6;

my $filename = "day02.input";

my @list;
my $rangestring;
my @range;
my $start;
my $stop;
#my $id;
my $sumid=0;

my sub chekid($id) {
    my $length=$id.chars;
    my $halve= $length div 2;
    my $pattern;
    my $patternmatch = False;
    loop ( my $i = 1 ; $i <= $halve; $i++) {
        next if $length % $i != 0;
        $pattern=$id.substr(0,$i);
        my $falsecount=0;
        my $t;
        loop (my $j = $i; $j <= $length-$i ; $j+=$i) {
            $t = $id.substr($j,$i);
            if $pattern == $t {
                $patternmatch=True;
            } else {
                $falsecount++;
                $j=$length;
            }
        }
        if $patternmatch and $falsecount==0 {
            #say "p=$pattern, i=$i, h=$halve, l=$length";
            return True;
        }
    }
return False;
}

for $filename.IO.lines -> $line {
    @list = $line.split(',');
    for @list -> $rangestring {
        @range = $rangestring.split('-');
        #say "@range[0] - @range[1]";
        loop ( my $i = @range[0]; $i <= @range[1]; $i++) {
            #print "$i,";
                if chekid($i) { 
                    #say $i; 
                    $sumid += $i;
                };
        }
    }
    
}
say "Sum av alled id'er=$sumid"; # 66500947346
