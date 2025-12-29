use v6;

my $filename="day12.input";

my @lines;
my $line;
my @packages;
my @regions;

my $packagelines = 0;
my @package = [];
for $filename.IO.lines -> $line { 
    
    @lines.push($line);
    if $line ~~ /^\d\:/ { 
        # nexte thre lines package
        $packagelines = 3;
        next;
    }
    if $packagelines > 0 {
        @package.push($line);
        $packagelines--;
        if $packagelines == 0 {
            @packages.push(@package.clone);
            @package=[];
        }
        next;
    }
    if $line ~~ /^\d+x\d+\:/ {
        my ($region,$packagelist) = $line.split(": ");
        my ($columns,$rows) = $region.split("x");
        my @numberofpackages = $packagelist.split(" ");
        @regions.push(($columns,$rows,@numberofpackages));
    }
}

#say @packages;
#say @regions;
my $packagesfit = 0;
for @regions -> @region {
    my $numberof3by3 = (@region[0] div 3) * (@region[1] div 3);
    my $numberofpackages = @region[2].sum;
    if $numberofpackages <= $numberof3by3 {
        $packagesfit++;
    }
}

say "Regions with room for packages = $packagesfit";

