! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: columns combinators io.encodings.utf8 io.files kernel math math.order
ranges sequences sequences.deep ;
IN: aoc2022.day8


: load-input ( path -- seq )
    utf8 file-lines [ [ CHAR: 0 - ] { } map-as ] map ;

! we assume that input array is bigger than 1x1
: count-edge-trees ( 2d-seq -- n )
    ! 2 * rows + 2 * cols - 4
    [ length 2 * ]
    [ first length 2 * 4 - ] bi + ;

:: visible-in-seq? ( i seq -- ? )
    i seq nth :> height
    seq i [
        head-slice [ height < ] all?
    ] [
        1 + tail-slice [ height < ] all?
    ] 2bi or ;

:: visible? ( i j 2d-seq -- ? )
    i 2d-seq nth :> row
    j row visible-in-seq?
    2d-seq j <column> :> col
    i col visible-in-seq?
    or ;

: count-inner-visible-trees ( 2d-seq -- n )
    dup length 1 - [1..b)
    over first length 1 - [1..b)
    rot [ visible? ] curry
    cartesian-map [ [ ] count ] map-sum ;

: calc-part1 ( 2d-seq -- n )
    [ count-edge-trees ]
    [ count-inner-visible-trees ] bi + ;

! example: up-view-distance without lexical vars
: uvd ( i j 2d-seq -- n )
    swap <column> ! i col
    2dup nth ! i col height
    [ over head-slice reverse ] dip ! i col-slice height
    [ >= ] curry find drop ! i found-idx
    ! I need found-idx found-idx i
    dup [ 1 + nip ] [ drop ] if ;

:: up-distance ( i j 2d-seq -- n )
    ! cut a column from 0 to i - 1 and find the last element >= height
    2d-seq j <column> :> col
    i col nth :> height
    col i head-slice reverse [ height >= ] find drop :> found-idx
    ! if we found no higher trees then the distance equal to row number
    found-idx [ found-idx 1 + ] [ i ] if ;

:: down-distance ( i j 2d-seq -- n )
    ! cut a column from i+1 to length - 1 and find the first element >= height
    2d-seq j <column> :> col
    i col nth :> height
    col i 1 + tail-slice :> col-slice
    col-slice [ height >= ] find drop :> found-idx
    found-idx [ found-idx 1 + ] [ col-slice length ] if ;

:: left-distance ( i j 2d-seq -- n )
    i 2d-seq nth :> row
    j row nth :> height
    row j head-slice reverse [ height >= ] find drop :> found-idx
    found-idx [ found-idx 1 + ] [ j ] if ; 

:: right-distance ( i j 2d-seq -- n )
    i 2d-seq nth :> row
    j row nth :> height
    row j 1 + tail-slice :> row-slice
    row-slice [ height >= ] find drop :> found-idx
    found-idx [ found-idx 1 + ] [ row-slice length ] if ;


! Part 2
: scenic-score ( i j 2d-seq -- n )
    {
        [ up-distance ]
        [ down-distance ]
        [ left-distance ]
        [ right-distance ]
    } 3cleave * * * ;

: calc-part2 ( 2d-seq -- n )
    ! we have to iterate
    dup length 1 - [1..b)
    over first length 1 - [1..b)
    rot [ scenic-score ] curry 
    cartesian-map flatten 0 [ max ] reduce ;
