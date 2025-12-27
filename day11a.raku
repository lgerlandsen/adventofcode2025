use v6;

my $filename="day11.input";
my $line;
my %lines;

for $filename.IO.lines -> $line { 
    my ($key,$valuestring) = $line.split(":");
    my @values = $valuestring.trim.split(" ");
    %lines{$key} = @values;
}

#say %lines.raku;


my $totalcount = 0;

sub findpath( @outputs ) {
    for @outputs -> $output {
        if $output eq "out" {
            $totalcount++;
        } elsif $output eq "you" {
            say "back to you, not correct";
        } else {
            findpath( %lines{$output}) ;
        }
    }
}

findpath(%lines{"you"});

say "Total possible paths = $totalcount";
