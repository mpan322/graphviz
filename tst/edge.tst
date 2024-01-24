#############################################################################
##
##  standard/dot.tst
##  Copyright (C) 2022                                   James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
gap> START_TEST("graphviz package: dot.tst");
gap> LoadPackage("graphviz", false);;

# Test edge constructor
gap> a := GV_Node("a");;
gap> b := GV_Node("b");;
gap> GV_Edge(a, b, rec(color := "red"));
<edge (a, b)>

# Test node constructor
gap> n := GV_Node("test-node", rec(color := "red"));
<node test-node>
gap> GV_Attrs(n);
rec( color := "red" )

#
