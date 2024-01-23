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

# Test creating an edge works
gap> g := GV_Graph();;
gap> GV_Edge(g, "a", "b");;
gap> GV_Lines(g);
[ [ "Head" ], [ "Edge", 1 ] ]
gap> GV_Edges(g);
[ [ "a", "b", rec(  ) ] ]

# Test creating an edge with properties works
gap> g := GV_Graph();;
gap> GV_Edge(g, "a", "b", rec(color := "red"));;
gap> GV_Edges(g);
[ [ "a", "b", rec( color := "red" ) ] ]
gap> GV_Lines(g);
[ [ "Head" ], [ "Edge", 1 ] ]

# Test creating a duplicate edge works
gap> g := GV_Graph();;
gap> GV_Edge(g, "a", "b", rec(color := "red"));;
gap> GV_Edge(g, "a", "b", rec(label := "duplicate"));;
gap> GV_Edges(g);
[ [ "a", "b", rec( color := "red" ) ], 
  [ "a", "b", rec( label := "duplicate" ) ] ]
gap> GV_Lines(g);
[ [ "Head" ], [ "Edge", 1 ], [ "Edge", 2 ] ]
gap> GV_String(g);
"graph  {\n\ta -- b [color=red]\n\ta -- b [label=\"duplicate\"]\n}\n"

# Add edge to specific line
gap> g := GV_Graph();;
gap> GV_Edge(g, "a", "b", rec(color := "red"));;
gap> GV_Edge(g, "e", "f", rec(color := "red"));;
gap> GV_Edge(g, "c", "d", 3);;
gap> GV_Edges(g);
[ [ "a", "b", rec( color := "red" ) ], [ "e", "f", rec( color := "red" ) ], 
  [ "c", "d", rec(  ) ] ]
gap> GV_Lines(g);
[ [ "Head" ], [ "Edge", 1 ], [ "Edge", 3 ], [ "Edge", 2 ] ]
gap> GV_String(g);
"graph  {\n\ta -- b [color=red]\n\tc -- d\n\te -- f [color=red]\n}\n"

# Remove an edge
gap> g := GV_Graph();;
gap> GV_Edge(g, "a", "b", rec(color := "red"));;
gap> GV_Edge(g, "e", "f", rec(color := "red"));;
gap> GV_Edge(g, "c", "d", 3);;
gap> GV_Remove(g, 2);;
gap> GV_Edges(g);
[ [ "e", "f", rec( color := "red" ) ], [ "c", "d", rec(  ) ] ]
gap> GV_Lines(g);
[ [ "Head" ], [ "Edge", 2 ], [ "Edge", 1 ] ]

#