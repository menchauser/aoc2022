! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: combinators io io.encodings.utf8 io.files kernel math math.parser
math.vectors namespaces prettyprint sequences sets splitting ;
IN: aoc2022.day9


SYMBOL: visited-positions


: too-long? ( tail head -- ? )
    v- [ abs 1 > ] any? ;

! Make one step in the direction
: head-step ( head direction -- new-head )
    {
        { "R" [ {  1  0 } v+ ] }
        { "U" [ {  0  1 } v+ ] }
        { "L" [ { -1  0 } v+ ] }
        { "D" [ {  0 -1 } v+ ] }
        [ drop "Invalid input" print ]
    } case ;

! simple solution: just encode decision table
! TODO: calculate tan/cotan 
: move-tail ( tail head -- new-tail )
    over v-
    ! starting from right go counter-clockwise
    {
        { {  2  0 } [ {  1  0 } v+ ] }
        { {  2  1 } [ {  1  1 } v+ ] }

        { {  1  2 } [ {  1  1 } v+ ] }
        { {  0  2 } [ {  0  1 } v+ ] }
        { { -1  2 } [ { -1  1 } v+ ] }

        { { -2  1 } [ { -1  1 } v+ ] }
        { { -2  0 } [ { -1  0 } v+ ] }
        { { -2 -1 } [ { -1 -1 } v+ ] }

        { { -1 -2 } [ { -1 -1 } v+ ] }
        { {  0 -2 } [ {  0 -1 } v+ ] }
        { {  1 -2 } [ {  1 -1 } v+ ] }

        { {  2 -1 } [ {  1 -1 } v+ ] }

        [ drop "Unexpected head" . ]
    } case
    ! update state
    dup visited-positions get adjoin ;

! Step for both head and tail
: full-step ( tail head direction -- new-tail new-head )
    head-step 2dup too-long? [
        [ move-tail ] keep
    ] when ;

! Fully move COUNT steps in given DIRECTION
: full-move ( tail head direction count -- new-tail new-head )
    <iota> [
        drop
        [ full-step ] keep
    ] each drop ;

: load-input ( path -- seq )
    utf8 file-lines [ " " split ] map ;

: calc-part1 ( cmds -- result )
    HS{ { 0 0 } } visited-positions namespaces:set
    [
        { 0 0 } { 0 0 } rot ! initial head and tail
        [
            [ first ] [ second string>number ]  bi
            full-move 
        ] each
        . .
        visited-positions get cardinality
    ] with-scope ; 
