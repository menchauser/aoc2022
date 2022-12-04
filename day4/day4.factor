! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: io.encodings.utf8 io.files kernel math math.order math.parser sequences
splitting ;
IN: aoc2022.day4


! Every seq elements contains pair of pairs
: load-input ( path -- seq )
    utf8 file-lines [
        "," split [ "-" split [ string>number ] map ] map
    ] map ;

: left-contain-right? ( l r -- ? )
    ! p1.1 >= p2.1 AND p1.2 <= p2.2
    [ first swap first >= ] 2keep
    second swap second <= and ;

: fully-contain? ( p1 p2 -- ? )
    [ left-contain-right? ] 2keep
    swap left-contain-right? or ;

: calc-part1 ( seq -- n )
    [ [ first ] [ second ] bi fully-contain? ] count ;

: left-overlaps-right? ( p1 p2 -- ? )
    [ first ] [ second ] bi [ between? ] 2curry any? ;

: overlaps? ( p1 p2 -- ? )
    [ left-overlaps-right? ] 2keep swap left-overlaps-right? or ;

: calc-part2 ( seq -- n )
    [ [ first ] [ second ] bi overlaps? ] count ;
