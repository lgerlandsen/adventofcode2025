use v6;
my $filename="day09.input";
my $line;

my @coordinates=[];
for $filename.IO.lines -> $line { 
    my ($x,$y) = $line.split(",");
    @coordinates.push(($x,$y));
}

sub rectangle(@a, @b) {
    my $l =  @a[0]>@b[0] ?? @a[0]-@b[0]+1  !! @b[0]-@a[0]+1;
    my $b =  @a[1]>@b[1] ?? @a[1]-@b[1]+1  !! @b[1]-@a[1]+1;
    return $l * $b;
}

# Point-in-polygon (ray casting). Inclusive on-edge handling optional.
sub point-in-polygon(@pt, @poly --> Bool) {
    my ($x, $y) = @pt;
    my $inside = False;
    my $n = @poly.elems;

    for ^$n -> $i {
        my $j = ($i + $n - 1) % $n;   # previous vertex (wrap)
        my ($xi, $yi) = @poly[$i];
        my ($xj, $yj) = @poly[$j];

        # Check if point lies exactly on the edge (inclusive boundary)
        if point-on-segment(@pt, @poly[$j], @poly[$i]) {
            return True;  # consider boundaries inside; change to False if you prefer exclusive
        }

        my $straddles = (($yi > $y) != ($yj > $y));
        if $straddles {
            my $x-intersect = (($xj - $xi) * ($y - $yi)) / (($yj - $yi) + 0e0) + $xi;
            if $x < $x-intersect {
                $inside = !$inside;
            }
        }
    }
    return $inside;
}

# Check if point Q lies on segment P–R (collinearity + bounding box)
sub point-on-segment(@q, @p, @r --> Bool) {
    my ($qx, $qy) = @q;
    my ($px, $py) = @p;
    my ($rx, $ry) = @r;

    # Collinear via cross product == 0
    my $cross = ($qx - $px) * ($ry - $py) - ($qy - $py) * ($rx - $px);
    return False unless $cross == 0;

    # Within bounding box
    return ($qx <= max($px, $rx) &&
            $qx >= min($px, $rx) &&
            $qy <= max($py, $ry) &&
            $qy >= min($py, $ry) );
}

# Orientation of triplet (p, q, r): 0 collinear, 1 clockwise, 2 counterclockwise
sub orientation(@p, @q, @r --> Int) {
    my $val = (@q[1] - @p[1]) * (@r[0] - @q[0]) - (@q[0] - @p[0]) * (@r[1] - @q[1]);
    return 0 if $val == 0;
    return $val > 0 ?? 1 !! 2;
}

# Segment intersection (inclusive): A–B with C–D
sub segments-intersect(@a, @b, @c, @d --> Bool) {
    my $o1 = orientation(@a, @b, @c);
    my $o2 = orientation(@a, @b, @d);
    my $o3 = orientation(@c, @d, @a);
    my $o4 = orientation(@c, @d, @b);

    # General case
    return True if $o1 != $o2 && $o3 != $o4;

    # Special collinear cases
    return True if $o1 == 0 && point-on-segment(@c, @a, @b);
    return True if $o2 == 0 && point-on-segment(@d, @a, @b);
    return True if $o3 == 0 && point-on-segment(@a, @c, @d);
    return True if $o4 == 0 && point-on-segment(@b, @c, @d);

    return False;
}

# Compute rectangle vertices from two opposite corners (axis-aligned)
sub rect-verts-from-two(@p1, @p2 --> List) {
    my ($x1, $y1) = @p1;
    my ($x2, $y2) = @p2;
    my $xmin = min($x1, $x2);
    my $xmax = max($x1, $x2);
    my $ymin = min($y1, $y2);
    my $ymax = max($y1, $y2);
    (
        [$xmin, $ymin],  # bottom-left
        [$xmax, $ymin],  # bottom-right
        [$xmax, $ymax],  # top-right
        [$xmin, $ymax],  # top-left
    )
}

# Rectangle fully inside polygon:
#  - all rectangle vertices inside polygon
#  - no rectangle edge intersects any polygon edge
sub rectangle-inside-polygon(@rect, @poly --> Bool) {
    # 1) Vertex containment
    for @rect -> @v {
        return False unless point-in-polygon(@v, @poly);
    }
    # 2) Edge intersection check
    my @rect-edges = gather for ^@rect.elems -> $i {
        my $j = ($i + 1) % @rect.elems;
        take [@rect[$i], @rect[$j]];
    }
    my @poly-edges = gather for ^@poly.elems -> $i {
        my $j = ($i + 1) % @poly.elems;
        take [@poly[$i], @poly[$j]];
    }
    for @rect-edges -> @re {
        for @poly-edges -> @pe {
            # Allow touching at shared vertices but disallow crossing
            my $inter = segments-intersect(@re[0], @re[1], @pe[0], @pe[1]);
            if $inter {
                # If intersection occurs at endpoints only AND those endpoints are inside, we consider still inside.
                my $shared-endpoint =
                    (point-on-segment(@re[0], @pe[0], @pe[1]) || @re[0] eqv @pe[0] | @pe[1]) ||
                    (point-on-segment(@re[1], @pe[0], @pe[1]) || @re[1] eqv @pe[0] | @pe[1]);
                if !$shared-endpoint {
                    # endpoint couldlie on rectangles line segment
                    $shared-endpoint=point-on-segment(@pe[0], @re[0], @re[1]) || 
                                     point-on-segment(@pe[1], @re[0], @re[1]);
                }
                return False unless $shared-endpoint;
            }
        }
    }
    True
}

my $largestrectangle=0;
loop ( my $i=0 ; $i < @coordinates.elems ; $i++ ) {
    loop ( my $j=$i+1 ; $j < @coordinates.elems ; $j++ ) {
        my @rect = rect-verts-from-two(@coordinates[$i],@coordinates[$j]); 
        if rectangle-inside-polygon(@rect,@coordinates) {
            my $size = rectangle(@coordinates[$i],@coordinates[$j]);
            if $size > $largestrectangle {$largestrectangle = $size;}
        }
    }
}
say "Største rektangel $largestrectangle";
