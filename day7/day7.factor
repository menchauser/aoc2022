! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors assocs combinators io io.encodings.utf8 io.files kernel math
math.order math.parser prettyprint.custom sequences splitting strings vectors ;
IN: aoc2022.day7

TUPLE: fs-tree
    parent
    { name string }
    { size number }
    { dir? boolean initial: f  }
    { children assoc } ;

: <file> ( size name -- tree )
    fs-tree new
    swap >>name
    swap >>size ;

: <dir> ( name -- tree )
    fs-tree new swap >>name
    V{ } clone >>children
    t >>dir? ;

: digit? ( c -- ? )
    CHAR: 0 CHAR: 9 between? ;

: parse-command ( path line -- )
    {
        { [ dup "$ cd .." head? ] [ drop pop* ] }
        { [ dup "$ cd" head? ]    [ 5 tail <dir> swap push ] }
        ! for ls command we do nothing
        [ 2drop ] 
    } cond ;

: parse-directory ( path line -- )
    4 tail <dir> [ last children>> ] dip ! children dir
    swap push ;

: parse-file ( path line -- )
    " " split1 [ string>number ] dip <file> [ last children>> ] dip ! children file
    swap push ;

! To parse next word we do need:
! - stack of tree elements (to be able to go ..)
! - the line to parse
! In return we get the new file path
! cd moves by path (creating new directories if needed)
! ls creates new subdirs
! path may be empty
: parse-line ( path line -- )
    ! first char is $ - command
    ! first char is digit - file
    ! first char is 'd' - dir
    {
        { [ dup "$" head? ] [ parse-command ] }
        { [ dup "d" head? ] [ parse-directory ] }
        { [ dup first digit? ] [ parse-file ] }
    } cond ;

: load-input ( path -- file-tree )
    utf8 file-lines
    V{ } clone swap ! stack file-lines
    [ dupd parse-line ] each ;
