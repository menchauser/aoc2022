! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: aoc2022.day8 tools.test ;
IN: aoc2022.day8.tests


{ f } [ 1 1
        { { 3 3 3 3 }
          { 3 3 3 3 }
          { 3 3 3 3 }
          { 3 3 3 3 } } visible? ] unit-test 

{ t } [ 1 1
        { { 3 3 3 3 }
          { 3 4 5 3 }
          { 3 6 7 3 }
          { 3 3 3 3 } } visible? ] unit-test 

{ t } [ 1 1
        { { 3 5 3 3 }
          { 5 3 5 5 }
          { 3 1 7 3 }
          { 3 1 3 3 } } visible? ] unit-test 

{ 4 } [ { { 1 2 }
          { 3 4 } } calc-part1 ] unit-test

{ 12 } [ { { 3 3 3 3 }
           { 3 3 3 3 }
           { 3 3 3 3 }
           { 3 3 3 3 } } calc-part1 ] unit-test 

{ 16 } [ { { 3 3 3 3 }
           { 3 4 5 3 }
           { 3 6 7 3 }
           { 3 3 3 3 } } calc-part1 ] unit-test 

{ 1 } [ 1 2 "test.txt" load-input up-distance ] unit-test
{ 1 } [ 1 2 "test.txt" load-input left-distance ] unit-test
{ 2 } [ 1 2 "test.txt" load-input down-distance ] unit-test
{ 2 } [ 1 2 "test.txt" load-input right-distance ] unit-test

{ 2 } [ 3 2 "test.txt" load-input up-distance ] unit-test
{ 2 } [ 3 2 "test.txt" load-input left-distance ] unit-test
{ 1 } [ 3 2 "test.txt" load-input down-distance ] unit-test
{ 2 } [ 3 2 "test.txt" load-input right-distance ] unit-test

{ 4 } [ 1 2 "test.txt" load-input scenic-score ] unit-test 
{ 8 } [ 3 2 "test.txt" load-input scenic-score ] unit-test

{ 8 } [ "test.txt" load-input calc-part2 ] unit-test
