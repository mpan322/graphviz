#############################################################################
##
##  standard/dot.tst
##  Copyright (C) 2022                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
# This is the test file for things to do with global attrs
gap> START_TEST("graphviz package: dot.tst");
gap> LoadPackage("graphviz", false);;

# Test adding a comment
gap> g := GV_Graph();;
gap> GV_Comment(g, "test-comment");;
gap> GV_Lines(g);
[ [ "Head" ], [ "Comment", 1 ] ]

# Test adding a comment with line number
gap> g := GV_Graph();;
gap> GV_Comment(g, "test-comment-t");;
gap> GV_Comment(g, "test-comment-b");;
gap> GV_Comment(g, "test-comment-m", 3);;
gap> GV_Lines(g);
[ [ "Head" ], [ "Comment", 1 ], [ "Comment", 3 ], [ "Comment", 2 ] ]
gap> GV_String(g);
"graph  {\n//test-comment-t\n//test-comment-m\n//test-comment-b\n}\n"

#