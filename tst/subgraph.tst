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

# Test creating a node works
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g, "test");;
gap> GV_Subgraphs(g);
[ "test" ]

#