! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: grouping io.encodings.utf8 io.files kernel math prettyprint sequences
sets ;
IN: aoc2022.day6


: find-marker ( str packet-size -- n )
    [ clump ] keep                          ! group input data by packet-size elements
    [ '[ cardinality _ = ] find drop ] keep ! find index of first unique-elements group
    + ;                                     ! add its index to group size to find the marker

: calc-part1 ( str -- n )
    4 find-marker ;

: run-part1 ( path -- n )
    utf8 file-contents calc-part1 ;

: calc-part2 ( str -- n )
    14 find-marker ;

: run-part2 ( path -- n )
    utf8 file-contents calc-part2 ;
