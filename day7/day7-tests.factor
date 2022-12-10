! Copyright (C) 2022 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: aoc2022.day7 arrays kernel sequences tools.test vectors ;
IN: aoc2022.day7.tests

: root-path ( -- path )
    "/" <dir> 1vector clone ;

! : build-path ( elements -- path )

root-path 1array
[ V{ } clone dup "$ cd /" parse-command ] unit-test 

root-path 1array
[ root-path 
  "child" <dir> over push
  dup "$ cd .." parse-command ] unit-test
  
root-path
1234 "a.txt" <file> push
1array
[ root-path
  dup "1234 a.txt" parse-file ] unit-test
