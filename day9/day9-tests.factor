! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test aoc2022.day9 ;
IN: aoc2022.day9.tests


{ f } [ { 0 0 } { 0 0 } too-long? ] unit-test
{ f } [ { 0 0 } { 1 0 } too-long? ] unit-test
{ f } [ { 0 0 } { 0 1 } too-long? ] unit-test
{ f } [ { 0 0 } { 1 1 } too-long? ] unit-test
{ t } [ { 0 0 } { 2 0 } too-long? ] unit-test
{ t } [ { 0 0 } { 1 2 } too-long? ] unit-test

{ { 1 0 } } [ { 0 0 } "R" head-step ] unit-test
{ { 1 2 } } [ { 2 2 } "L" head-step ] unit-test
{ { 1 3 } } [ { 1 2 } "U" head-step ] unit-test
{ { 1 2 } } [ { 1 3 } "D" head-step ] unit-test

! right
{ { 0 0 } { 1 0 } }
[ { 0 0 } { 0 0 } "R" full-step ] unit-test 

{ { 1 0 } { 2 0 } }
[ { 0 0 } { 1 0 } "R" full-step ] unit-test 

! up-right
{ { 1 1 } { 2 1 } }
[ { 0 0 } { 1 1 } "R" full-step ] unit-test
