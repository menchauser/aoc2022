! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors grouping io io.encodings.utf8 io.files kernel make math
math.parser peg prettyprint sequences splitting strings ;
IN: aoc2022.day5


TUPLE: op count from to ;

: number ( -- parser ) CHAR: 0 CHAR: 9 range repeat1 ;

: op-parser ( -- parser )
    [ "move " token hide ,
      number ,
      " from " token hide ,
      number ,
      " to " token hide ,
      number , ] seq* [
        [ >string string>number ] map first3 op boa
    ] action ;

: parse-op ( str -- op )
    op-parser parse ;

: blank? ( c -- c ? )
    dup " " = ;

! Put char c to nth stack if it is non-empty
: put ( stacks c n -- stacks )
    pick nth push ;

: parse-symbols ( line -- seq )
    " " prepend 4 group
    [
        2 swap nth 1string blank? [ drop f ] when
    ] map ;

: parse-line-into-stacks ( stacks line -- stacks )
    parse-symbols
    [| elt idx | elt [ elt idx put ] when ] each-index ;


! The stupid way: insert a space in the beginning, group seq by 4 elements
: parse-stacks ( lines -- stacks )
    reverse rest ! remove numbers | lines
    9 [ V{ } clone ] replicate ! let's create output | lines stacks
    swap [ parse-line-into-stacks ] each ;
    

: load-input ( path -- stacks ops )
    utf8 file-lines { "" } split1
    [ parse-stacks ] dip
    [ parse-op ] map ;

:: execute-op-part1 ( stacks op -- stacks )
    op from>> 1 - stacks nth :> from-stack
    op to>> 1 - stacks nth :> to-stack
    op count>> <iota> [ drop from-stack pop to-stack push ] each
    stacks ;

! : execute-ops ( stacks ops executer: ( ... ops -- ... ) -- stacks )
    ! each ;

: calc-part1 ( stacks ops -- result )
    [ execute-op-part1 ] each [ ?last ] map "" join ;
    
:: execute-op-part2 ( stacks op -- stacks )
    op from>> 1 - stacks nth :> from-stack
    op to>> 1 - stacks nth :> to-stack
    op count>> :> N
    to-stack from-stack N tail* append! drop
    from-stack length dup N - swap from-stack delete-slice
    stacks ;

: calc-part2 ( stacks ops -- result )
    [ execute-op-part2 ] each [ ?last ] map "" join ;
