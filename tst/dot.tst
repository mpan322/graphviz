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

# Test setting attributes
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "test");;
gap> GraphvizSetAttrs(n, rec(color:="red", label:="lab"));;
gap> GraphvizAttrs(n);
rec( color := "red", label := "lab" )
gap> GraphvizSetAttrs(n, rec(color:="blue"));;
gap> GraphvizAttrs(n);
rec( color := "blue", label := "lab" )

# Test globals
gap> g := GraphvizGraph();;
gap> GraphvizSetAttrs(g, rec( color := "red", shape := "circle" ));;
gap> GraphvizAttrs(g);
[ "color=\"red\"", "shape=\"circle\"" ]
gap> GraphvizSetAttrs(g, rec( color := "blue", label := "test" ));;
gap> GraphvizAttrs(g);
[ "color=\"red\"", "shape=\"circle\"", "label=test", "color=\"blue\"" ]

# Test stringify
gap> g := GraphvizGraph();;
gap> n := GraphvizAddNode(g, "test");;
gap> GraphvizSetAttrs(n, rec(color:="red", label:="lab"));;
gap> AsString(g);
"graph  {\n\t\"test\" [color=\"red\", label=lab]\n}\n"

# Test stringify with edge (digraphs)
gap> g := GraphvizDigraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> GraphvizSetAttrs(a, rec(color:="blue"));;
gap> GraphvizSetAttrs(b, rec(color:="red"));;
gap> e := GraphvizAddEdge(g, a, b);;
gap> GraphvizSetAttrs(e, rec(color:="green"));;
gap> AsString(g);
"digraph  {\n\t\"a\" [color=\"blue\"]\n\t\"b\" [color=\"red\"]\n\t\"a\" -> \"b\
\" [color=\"green\"]\n}\n"

# Test stringify with edge (graph)
gap> g := GraphvizGraph();;
gap> a := GraphvizAddNode(g, "a");;
gap> b := GraphvizAddNode(g, "b");;
gap> GraphvizSetAttrs(a, rec(color:="blue"));;
gap> GraphvizSetAttrs(b, rec(color:="red"));;
gap> e := GraphvizAddEdge(g, a, b);;
gap> GraphvizSetAttrs(e, rec(color:="green"));;
gap> AsString(g);
"graph  {\n\t\"a\" [color=\"blue\"]\n\t\"b\" [color=\"red\"]\n\t\"a\" -- \"b\"\
 [color=\"green\"]\n}\n"

# Test stringify empty
gap> g := GraphvizGraph();;
gap> AsString(g);
"graph  {\n}\n"

#
gap> STOP_TEST("Digraphs package: standard/oper.tst", 0);
