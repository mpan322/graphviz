#############################################################################
##
##  node.tst
##  Copyright (C) 2024                                      Matthew Pancer
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##

#@local color, g, label, n, s, shape, t, k
gap> START_TEST("graphviz package: node.tst");
gap> LoadPackage("graphviz", false);;

# Test node constructor
gap> GraphvizAddNode(GraphvizGraph(), "test-node");
<graphviz node "test-node">

# Test renaming nodes fails
gap> n := GraphvizAddNode(GraphvizGraph(), "a");;
gap> GraphvizName(n, "test");
Error, no method found! For debugging hints type ?Recovery from NoMethodFound
Error, no 1st choice method found for `GraphvizName' on 2 arguments

# Test making a node with an all whitespace name
gap> n := GraphvizAddNode(GraphvizGraph(), "  ");
<graphviz node "  ">

# Test making a node with empty name fails
gap> n := GraphvizAddNode(GraphvizGraph(), "");
Error, the 2nd argument (string/node name) cannot be empty

# Test whitespace in node names
gap> n := GraphvizAddNode(GraphvizGraph(), "a  a   ");
<graphviz node "a  a   ">

# Test modifying attributes
gap> n := GraphvizAddNode(GraphvizGraph(), "t");;
gap> GraphvizSetAttrs(n, rec(color := "red"));;
gap> GraphvizSetAttrs(n, rec(color := "blue", shape := "round"));;
gap> GraphvizAttrs(n);
rec( color := "blue", shape := "round" )
gap> GraphvizSetAttrs(n, rec(color := "green", label := "test"));;
gap> GraphvizAttrs(n);
rec( color := "green", label := "test", shape := "round" )

# Test removing attributes
gap> n := GraphvizAddNode(GraphvizGraph(), "t");;
gap> GraphvizSetAttrs(n, rec(color := "red", shape := "circle"));;
gap> GraphvizRemoveAttr(n, "color");;
gap> GraphvizAttrs(n);
rec( shape := "circle" )

# Test name containing ':'
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, "test:colon");;
gap> AsString(g);
"//dot\ngraph  {\n\ttest:colon\n}\n"

# Test non-string name containing ':'
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, 111);
<graphviz node "111">
gap> AsString(g);
"//dot\ngraph  {\n\t111\n}\n"
gap> n[1];
fail
gap> n[1] := 2;
2
gap> n[1];
"2"
gap> GraphvizRemoveAttr(n, 1);
<graphviz node "111">
gap> n[1];
fail

# Test removing a node with a non-string name
gap> g := GraphvizGraph();;
gap> GraphvizAddNode(g, 111);;
gap> GraphvizRemoveNode(g, 111);;
gap> GraphvizNodes(g);
rec(  )

# Test setting attributes using the []:= syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "a");;
gap> n["color"] := "red";;
gap> GraphvizAttrs(n);
rec( color := "red" )
gap> n["label"] := 1;;
gap> GraphvizAttrs(n);
rec( color := "red", label := "1" )
gap> n["color"] := "blue";;
gap> GraphvizAttrs(n);
rec( color := "blue", label := "1" )

# Test getting attributes using the [] syntax
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "a");;
gap> n["color"] := "red";;
gap> n["color"];
"red"

# Test set label (node)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetAttr(n, "label", "test");;
gap> GraphvizAttrs(n);
rec( label := "test" )

# Test set color (node)
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizSetAttr(n, "color", "red");;
gap> GraphvizAttrs(n);
rec( color := "red" )

# Test adding a node object directly fails
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> s := GraphvizGraph();;
gap> GraphvizAddNode(s, n);
Error, it is not currently possible to add Graphviz node objects directly to G\
raphviz graphs or digraphs, use the node's name instead

# Test attaching graphs to nodes works
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> s := GraphvizGraph("test");;
gap> GraphvizAttachGraphOrDigraph(n, s);
<graphviz node "n">
gap> GraphvizHasAttachedGraphOrDigraph(n);
true
gap> GraphvizGetAttachedGraphOrDigraph(n);
<graphviz graph "test" with 0 nodes and 0 edges>

# Test attaching digraphs also works
gap> g := GraphvizDigraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> s := GraphvizDigraph("test");;
gap> GraphvizAttachGraphOrDigraph(n, s);
<graphviz node "n">
gap> GraphvizHasAttachedGraphOrDigraph(n);
true
gap> GraphvizGetAttachedGraphOrDigraph(n);
<graphviz digraph "test" with 0 nodes and 0 edges>

# Test attaching if there is already an attached graph fails.
gap> g := GraphvizDigraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> s := GraphvizDigraph("test");;
gap> t := GraphvizDigraph("test");;
gap> GraphvizAttachGraphOrDigraph(n, s);;
gap> GraphvizAttachGraphOrDigraph(n, t);
Error, node "n" already has the digraph "test" attached
gap> t := GraphvizGraph("test");;
gap> GraphvizAttachGraphOrDigraph(n, t);
Error, node "n" already has the graph "test" attached

# Test getting an attached graph fails if there is none.
gap> g := GraphvizDigraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizGetAttachedGraphOrDigraph(n);
Error, node "n" has no attached graph or digraph

# Test nodes do not have attached graphs by default.
gap> g := GraphvizDigraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizHasAttachedGraphOrDigraph(n);
false

# Test detaching fails if no graphs are attached.
gap> g := GraphvizDigraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizDetachGraphOrDigraph(n);
Error, node "n" has no attached graph or digraph

# Test detaching normally succeeds
gap> g := GraphvizDigraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> t := GraphvizGraph("test");;
gap> GraphvizAttachGraphOrDigraph(n, t);;
gap> GraphvizDetachGraphOrDigraph(n);
<graphviz node "n">
gap> GraphvizHasAttachedGraphOrDigraph(n);
false

# Test attaching graph to its own node
gap> g := GraphvizDigraph();;
gap> n := GraphvizAddNode(g, "n");;
gap> GraphvizAttachGraphOrDigraph(n, g);
Error, cannot add graph, it will create a cyclic image dependency

# Test attaching graph with long cycle fails
gap> g := GraphvizDigraph("a");;
gap> n := GraphvizAddNode(g, "n");;
gap> t := GraphvizDigraph("b");;
gap> GraphvizAttachGraphOrDigraph(n, t);;
gap> n := GraphvizAddNode(t, "n");;
gap> t := GraphvizDigraph("d");;
gap> GraphvizAttachGraphOrDigraph(n, t);;
gap> n := GraphvizAddNode(t, "n");;
gap> t := GraphvizDigraph("e");;
gap> GraphvizAttachGraphOrDigraph(n, t);;
gap> n := GraphvizAddNode(t, "n");;
gap> GraphvizAttachGraphOrDigraph(n, g);
Error, cannot add graph, it will create a cyclic image dependency

# Test cycle through subgraph
gap> g := GraphvizDigraph("a");;
gap> s := GraphvizAddSubgraph(g, "s1");;
gap> n := GraphvizAddNode(s, "n");;
gap> t := GraphvizDigraph("b");;
gap> GraphvizAttachGraphOrDigraph(n, t);;
gap> s := GraphvizAddSubgraph(t, "s2");;
gap> n := GraphvizAddNode(s, "n");;
gap> GraphvizAttachGraphOrDigraph(n, g);;
Error, cannot add graph, it will create a cyclic image dependency

# Test weak cycles are fine
gap> g := GraphvizDigraph("a");;
gap> n := GraphvizAddNode(g, "n");;
gap> k := GraphvizAddNode(g, "k");;
gap> t := GraphvizDigraph("t");;
gap> GraphvizAttachGraphOrDigraph(n, t);
<graphviz node "n">
gap> GraphvizAttachGraphOrDigraph(k, t);
<graphviz node "k">

#
gap> STOP_TEST("graphviz package: node.tst", 0);
