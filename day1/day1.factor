! Copyright (C) 2022 Mukhamed Karanashev.
! See http://factorcode.org/license.txt for BSD license.
USING: io.encodings.utf8 io.files math.order math.parser sequences sorting
splitting ;
IN: aoc2022.day1

: load-input ( path -- seq )
    utf8 file-lines
    [ string>number ] map { f } split ;

: calc-part1 ( seq -- n )
    [ sum ] map 0 [ max ] reduce ;

: calc-part2 ( seq -- n )
    [ sum ] map [ >=< ] sort 3 head sum ;
