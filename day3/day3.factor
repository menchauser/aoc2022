! Copyright (C) 2022 Mukhamed Karanashev.
! See http://factorcode.org/license.txt for BSD license.
USING: combinators grouping io.encodings.utf8 io.files kernel math math.order
sequences sets ;
IN: aoc2022.day3


: load-input ( path -- str-seq )
    utf8 file-lines ;

: calc-priority ( c -- n )
    {
        { [ dup CHAR: a CHAR: z between? ] [ CHAR: a - 1 + ] }
        { [ dup CHAR: A CHAR: Z between? ] [ CHAR: A - 27 + ] }
        [ throw ]
    } cond ;

: find-wrong-item ( str -- c )
    dup length 2 / cut intersect first ;

: calc-part1 ( str-seq -- n )
    [ find-wrong-item calc-priority ] map sum ;

: calc-part2 ( str-seq -- n )
    3 group [ intersect-all first calc-priority ] map sum ;
