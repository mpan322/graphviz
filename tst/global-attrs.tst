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

# Test that adding node attribute works
gap> g := GV_Graph("add");;
gap> GV_NodeAttr(g, rec(color := "red"));;
gap> GV_NodeAttrs(g);
[ rec( color := "red" ) ]

# Test that adding node attribute at specific line works
gap> g := GV_Graph("add");;
gap> GV_NodeAttr(g, rec(color := "red"));;
gap> GV_NodeAttr(g, rec(color := "green"), 2);;
gap> GV_NodeAttr(g, rec(color := "blue"), 4);;
gap> GV_String(g);
"graph add {\n\tnode  [color=green]\n\tnode  [color=red]\n\tnode  [color=blue]\
\n}\n"

# Test that adding edge attribute works
gap> g := GV_Graph("add");;
gap> GV_EdgeAttr(g, rec(color := "red"));;
gap> GV_EdgeAttrs(g);
[ rec( color := "red" ) ]

# Test that adding edge attribute at specific line works
gap> g := GV_Graph("add");;
gap> GV_EdgeAttr(g, rec(color := "red"));;
gap> GV_EdgeAttr(g, rec(color := "green"), 2);;
gap> GV_EdgeAttr(g, rec(color := "blue"), 4);;
gap> GV_String(g);
"graph add {\n\tedge  [color=green]\n\tedge  [color=red]\n\tedge  [color=blue]\
\n}\n"

# Test that adding graph attributes works
gap> g := GV_Graph("add");;
gap> GV_GraphAttr(g, rec(color := "red"));;
gap> GV_GraphAttrs(g);
[ rec( color := "red" ) ]

# Test that adding graph attributes at specific line works
gap> g := GV_Graph("add");;
gap> GV_GraphAttr(g, rec(color := "red"));;
gap> GV_GraphAttr(g, rec(color := "blue"), 4);;
gap> GV_GraphAttr(g, rec(color := "green"), 3);;
gap> GV_String(g);
"graph add {\n\tcolor=\"red\" \n\tcolor=\"green\" \n\tcolor=\"blue\" \n}\n"

# Test removing a graph attr works
gap> g := GV_Graph("add");;
gap> GV_GraphAttr(g, rec(color := "red"));;
gap> GV_GraphAttr(g, rec(color := "blue"), 4);;
gap> GV_GraphAttr(g, rec(color := "green"), 3);;
gap> GV_Remove(g, 2);;
gap> GV_GraphAttrs(g);
[ rec( color := "blue" ), rec( color := "green" ) ]
gap> GV_Lines(g);
[ [ "Head" ], [ "GraphAttr", 2 ], [ "GraphAttr", 1 ] ]
gap> GV_String(g);
"graph add {\n\tcolor=\"green\" \n\tcolor=\"blue\" \n}\n"

# Test removing a edge attr works
gap> g := GV_Graph("add");;
gap> GV_EdgeAttr(g, rec(color := "red"));;
gap> GV_EdgeAttr(g, rec(color := "blue"), 4);;
gap> GV_EdgeAttr(g, rec(color := "green"), 3);;
gap> GV_Remove(g, 2);;
gap> GV_EdgeAttrs(g);
[ rec( color := "blue" ), rec( color := "green" ) ]
gap> GV_Lines(g);
[ [ "Head" ], [ "EdgeAttr", 2 ], [ "EdgeAttr", 1 ] ]
gap> GV_String(g);
"graph add {\n\tedge  [color=green]\n\tedge  [color=blue]\n}\n"

# Test removing a node attr works
gap> g := GV_Graph("add");;
gap> GV_NodeAttr(g, rec(color := "red"));;
gap> GV_NodeAttr(g, rec(color := "blue"), 4);;
gap> GV_NodeAttr(g, rec(color := "green"), 3);;
gap> GV_Remove(g, 2);;
gap> GV_NodeAttrs(g);
[ rec( color := "blue" ), rec( color := "green" ) ]
gap> GV_Lines(g);
[ [ "Head" ], [ "NodeAttr", 2 ], [ "NodeAttr", 1 ] ]
gap> GV_String(g);
"graph add {\n\tnode  [color=green]\n\tnode  [color=blue]\n}\n"

#