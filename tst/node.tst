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

# Place nodes on lines in middle
gap> g := GV_Graph();;
gap> GV_Node(g, "test-node-t");;
gap> GV_Node(g, "test-node-b");;
gap> GV_Node(g, "test-node-m", 3);;
gap> GV_Lines(g);
[ [ "Head" ], [ "Node", "test-node-t" ], [ "Node", "test-node-m" ], 
  [ "Node", "test-node-b" ] ]
gap> GV_String(g);
"graph  {\n\ttest-node-t\n\ttest-node-m\n\ttest-node-b\n}\n"

# Test remove node
gap> g := GV_Graph();;
gap> GV_Node(g, "test-node-t");;
gap> GV_Node(g, "test-node-b");;
gap> GV_Node(g, "test-node-m", 3);;
gap> GV_Remove(g, 3);;
gap> GV_Lines(g);
[ [ "Head" ], [ "Node", "test-node-t" ], [ "Node", "test-node-b" ] ]
gap> GV_Nodes(g);
rec( ("test-node-b") := rec(  ), ("test-node-t") := rec(  ) )

#