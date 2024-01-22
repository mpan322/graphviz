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

#
gap> g := GV_Graph("add");;
gap> GV_NodeAttr(g, rec(color := "red"));;
gap> GV_NodeAttrs(g);
[ rec( color := "red" ) ]
