! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: aoc2022.day5 kernel sequences tools.test ;
IN: aoc2022.day5.tests

{ { f "D" "V" } }
[ "    [D] [V]" parse-symbols ] unit-test

{ { V{ } V{ "A" } V{ "B" } } }
[ 3 [ V{ } clone ] replicate "    [A] [B]" parse-line-into-stacks ] unit-test

{ { V{ } V{ "A" "B" } V{ } } }
[ { V{ } V{ "A" } V{ "B" } } 1 3 2 op boa execute-op ] unit-test
