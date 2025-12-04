use v6;

my $filename = "day02.input";

my @list;
my $rangestring;
my @range;
my $start;
my $stop;
my $id;
my $sumid=0;

my sub chekid($id) {
    my $length=$id.chars;
    my $halve= $length/2;
    substr($id,0,$halve) == substr($id,$halve,$halve);
}

for $filename.IO.lines -> $line {
    @list = $line.split(',');
    for @list -> $rangestring {
        @range = $rangestring.split('-');
        #say "@range[0] - @range[1]";
        loop ( my $i = @range[0]; $i <= @range[1]; $i++) {
            #print "$i,";
            if $i.chars % 2 == 0 {
                if chekid($i) { 
                    say $i; 
                    $sumid += $i;
                };

            }
        }
    }
    
}
say "Sum av alled id'er=$sumid"; 
