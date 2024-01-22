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
gap> GV_Node(g, "test-node");;
gap> GV_Nodes(g);
rec( ("test-node") := rec(  ) )

# Test creating a node with properties works
gap> g := GV_Graph();;
gap> GV_Node(g, "test-node", rec(color := "red", label := "test"));;
gap> GV_Nodes(g);
rec( ("test-node") := rec( color := "red", label := "test" ) )

# Test creating a node with same name works
gap> g := GV_Graph();;
gap> GV_Node(g, "test-node");;
gap> GV_Node(g, "test-node", rec(color := "red"));;
gap> GV_Nodes(g);
rec( ("test-node") := rec( color := "red" ) )
gap> GV_Lines(g);
[ [ "Head" ], [ "Node", "test-node" ] ]
gap> GV_String(g);
"graph  {\n\ttest-node [color=red]\n}\n"

# Place nodes on lines which are larger than the number of lines
gap> g := GV_Graph();;
gap> GV_Node(g, "test-node", rec(), 10);;
gap> GV_Lines(g);
[ [ "Head" ], [ "Node", "test-node" ] ]
gap> GV_String(g);
"graph  {\n\ttest-node\n}\n"

#
