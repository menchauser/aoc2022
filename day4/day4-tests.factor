! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test aoc2022.day4 ;
IN: aoc2022.day4.tests

{ f } [ { 2 4 } { 6 8 } fully-contain? ] unit-test
{ t } [ { 2 8 } { 3 7 } fully-contain? ] unit-test
{ t } [ { 3 7 } { 2 8 } fully-contain? ] unit-test

{ 2 } [ "test.txt" load-input calc-part1 ] unit-test

{ t } [ { 5 7 } { 7 9 } overlaps? ] unit-test
{ t } [ { 2 8 } { 3 7 } overlaps? ] unit-test
{ t } [ { 6 6 } { 4 6 } overlaps? ] unit-test
{ f } [ { 1 2 } { 3 4 } overlaps? ] unit-test
