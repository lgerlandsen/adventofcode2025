use v6;

my $filename="day07.input";
my $line;
my $previousline="";
my $splitcount=0;
for $filename.IO.lines -> $line {
    my $newline;
    if $previousline eq "" { 
        $previousline = $line;
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
                } elsif $i==$line.chars-1 {  
                    $splitcount++;
                    $newline = substr($newline,0,$i-1) ~"S^";
                } else {
                    $splitcount++;
                    $newline = substr($newline,0,$i-1) ~ "S^S" ~ substr($newline,$i+2);
                }
            }
        }
    }
    $previousline = $newline;
    #say $newline;
}

say "Total splits $splitcount";
