! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test aoc2022.day3 ;
IN: aoc2022.day3.tests

{ 16 } [ CHAR: p calc-priority ] unit-test
{ 38 } [ CHAR: L calc-priority ] unit-test

{ CHAR: p } [ "vJrwpWtwJgWrhcsFMMfFFhFp" find-wrong-item ] unit-test 

{ 157 } [ "test.txt" load-input calc-part1 ] unit-test 
{ 70 }  [ "test.txt" load-input calc-part2 ] unit-test
