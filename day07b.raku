use v6;

my $filename="day07.input";
my $line;
my $previousline="";
my $splitcount=0;
my @timelines;
for $filename.IO.lines -> $line {
    my $newline;
    if $previousline eq "" { 
        $previousline = $line;
        @timelines = 0 xx $line.chars;
        loop ( my $i = 0; $i < $line.chars ; $i++ ) {
            if substr($line,$i,1) eq "S" {
                @timelines[$i]=1;
            }
        }
        #say $line;
        next;
    }
    $newline = $line;
    loop ( my $i = 0; $i < $line.chars ; $i++ ) {
        if substr($previousline,$i,1) eq "S" {
            if substr($line,$i,1) eq "." {
                $newline = substr($newline,0,$i) ~ "S" ~ substr($newline,$i+1);
            } elsif substr($line,$i,1) eq "^" { #forutsetter at ^^ ikke forekommer
                if $i == 0 {
                    $splitcount++;
                    $newline = "^S" ~ substr($newline,$i+2);
                    @timelines[$i+1] += @timelines[$i];
                    @timelines[$i]=0;
                } elsif $i==$line.chars-1 {  
                    $splitcount++;
                    $newline = substr($newline,0,$i-1) ~"S^";
                    @timelines[$i-1] += @timelines[$i];
                    @timelines[$i]=0;
                } else {
                    $splitcount++;
                    $newline = substr($newline,0,$i-1) ~ "S^S" ~ substr($newline,$i+2);
                    @timelines[$i+1] += @timelines[$i];
                    @timelines[$i-1] += @timelines[$i];
                    @timelines[$i]=0;
                }
            }
        }
    }
    $previousline = $newline;
    #say $newline;
}
say "Total splits $splitcount"; 
say "Total timelines " ~ @timelines.sum;
