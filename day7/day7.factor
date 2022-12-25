! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators io io.encodings.utf8 io.files kernel
math math.order math.parser namespaces prettyprint.custom sequences splitting
strings vectors ;
IN: aoc2022.day7

TUPLE: fs-node
    parent
    { name string }
    { size number }
    { dir? boolean initial: f  }
    { children assoc } ;

: <file> ( parent size name -- fs-node )
    fs-node new
    swap >>name
    swap >>size
    swap >>parent
    dup parent>> [ children>> dupd push ] when* ;

: <dir> ( parent name -- fs-node )
    fs-node new
    swap >>name
    swap >>parent
    V{ } clone >>children
    t >>dir?
    ! append this to parent's children (doesn't look good)
    dup parent>> [ children>> dupd push ] when* ;

: digit? ( c -- ? )
    CHAR: 0 CHAR: 9 between? ;

! Current working directory
SYMBOL: CWD

: parse-command ( line -- )
    {
        { [ dup "$ cd .." head? ] [ drop CWD get parent>> CWD set ] }
        { [ dup "$ cd" head? ]    [ 5 tail
                                    CWD get children>>
                                    swap '[ name>> _ = ] find nip CWD set ] }
        ! for ls command we do nothing
        [ drop ] 
    } cond ;

: parse-directory ( line -- )
    4 tail CWD get swap <dir> drop ;

: parse-file ( line -- )
    " " split1 [ string>number ] dip CWD get -rot <file> drop ;

! To parse next word we do need:
! - stack of tree elements (to be able to go ..)
! - the line to parse
! In return we get the new file path
! cd moves by path (creating new directories if needed)
! ls does nothing
! path may be empty
: parse-line ( line -- )
    ! first char is $ - command
    ! first char is digit - file
    ! first char is 'd' - dir
    {
        { [ dup "$" head? ] [ parse-command ] }
        { [ dup "d" head? ] [ parse-directory ] }
        { [ dup first digit? ] [ parse-file ] }
    } cond ;

! Load and store root in CWD
: load-input ( path -- fs-node-root )
    ! we assume that first command is always "$ cd /"
    utf8 file-lines rest
    f "/" <dir> CWD set
    [ parse-line ] each
    CWD get
    [ dup parent>> ] ! while there is a non-null parent
    [ parent>> CWD set CWD get ] do while ;

! calculates node size and writes it into the node as side-effect
: calc-size! ( fs-node -- size )
    dup size>> 0 > [ size>> ] [
        dup children>> [ calc-size! ] map sum >>size
        size>>
    ] if ;

: find-small-nodes ( fs-node -- seq )
    dup size>> 100000 <= [
        dup 1array
    ] [
        { }
    ] if
    swap children>> [ find-small-nodes ] map concat prepend ;

: calc-part1 ( fs-node -- total-sum )
    ! Find all the directories with size < 100_000 and collect their sum
    ! To do that we have to traverse recursively
    dup calc-size! drop
    find-small-nodes [ dir?>> ] filter [ size>> ] map sum ;
