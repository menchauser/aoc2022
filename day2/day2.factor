! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: assocs io.encodings.utf8 io.files kernel math sequences sets splitting
strings ;
IN: aoc2022.day2

: load-input ( path -- seq )
    utf8 file-lines [ CHAR: space swap remove ] map ;

CONSTANT: shape-scores H{ { "X" 1 }
                          { "Y" 2 }
                          { "Z" 3 } }

CONSTANT: game-scores H{ { "AY" 6 }
                         { "BZ" 6 }
                         { "CX" 6 }
                         { "AX" 3 }
                         { "BY" 3 }
                         { "CZ" 3 } }

: win-score ( round -- n )
    game-scores at dup 0 ? ;
    

! score consists of two parts: my shape and outcome result
: round-score ( round -- n )
    [ second 1string shape-scores at ] ! based on my shape
    [ win-score ] ! based on round outcome
    bi + ;

: calc-part1 ( seq -- n )
    [ round-score ] map sum ;

! Part 2

: outcome-score ( c -- n ) CHAR: X - 3 * ;

! Gets pair, guesses the choice according to outcome, returns its score
: find-outcome-score ( pair -- score )
    [ first CHAR: A - 1 + ]
    [ second "YZX" index ]
    bi + 1 - 3 mod 1 + ;
        
: round-score-2 ( round -- n )
    [ find-outcome-score ] ! based on my shape
    [ second outcome-score ] ! based on the round outcome
    bi + ;

: calc-part2 ( seq -- n )
    [ round-score-2 ] map sum ;
