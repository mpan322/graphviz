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

# Test creating a subgraph works
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g, "test");;
gap> GV_Subgraphs(g);
[ "test" ]

# Test creating a subgraph works (w/ line number)
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g, "test-t");;
gap> GV_BeginSubgraph(g, "test-b");;
gap> GV_BeginSubgraph(g, "test-m", 3);;
gap> GV_Subgraphs(g);
[ "test-t", "test-b", "test-m" ]
gap> GV_Lines(g);
[ [ "Head" ], [ "SubBegin", 1 ], [ "SubBegin", 3 ], [ "SubBegin", 2 ] ]

# Test creating a subgraph works (w/ no name)
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g);;
gap> GV_Subgraphs(g);
[ "" ]
gap> GV_Lines(g);
[ [ "Head" ], [ "SubBegin", 1 ] ]

# Test creating a subgraph end works
gap> g := GV_Graph();;
gap> GV_EndSubgraph(g);;
gap> GV_Lines(g);
[ [ "Head" ], [ "SubEnd" ] ]

# Test creating a subgraph end works (w/ line number)
gap> g := GV_Graph();;
gap> GV_Node(g, "test-t");;
gap> GV_Node(g, "test-b");;
gap> GV_EndSubgraph(g, 3);;
gap> GV_Lines(g);
[ [ "Head" ], [ "Node", "test-t" ], [ "SubEnd" ], [ "Node", "test-b" ] ]

# Test stringifying w/ more begin subgraphs than endings
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g);;
gap> GV_String(g);
"Failed to output - Too few ending brackets\n"

# Test stringifying w/ too many closing brackets
gap> g := GV_Graph();;
gap> GV_EndSubgraph(g);;
gap> GV_String(g);
"Failed to output - Too many ending brackets. Line: 2\n"

# Test stringifying w/ nested correctly
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g);;
gap> GV_BeginSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_String(g);
"graph  {\n\tsubgraph  {\n\tsubgraph  {\n\t}\n\t}\n}\n"

# Test stringifying w/ nested too few close
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g);;
gap> GV_BeginSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_String(g);
"Failed to output - Too few ending brackets\n"

# Test stringifying w/ nested too many close
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g);;
gap> GV_BeginSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_String(g);
"Failed to output - Too many ending brackets. Line: 6\n"

# Test stringifying w/ many subgraphs
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g);;
gap> GV_BeginSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_BeginSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_String(g);
"graph  {\n\tsubgraph  {\n\tsubgraph  {\n\t}\n\t}\n\tsubgraph  {\n\t}\n}\n"

# Test stringifying w/o name
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g);;
gap> GV_EndSubgraph(g);;
gap> GV_String(g);
"graph  {\n\tsubgraph  {\n\t}\n}\n"

# Test stringifying w/ name
gap> g := GV_Graph();;
gap> GV_BeginSubgraph(g, "name");;
gap> GV_EndSubgraph(g);;
gap> GV_String(g);
"graph  {\n\tsubgraph name {\n\t}\n}\n"

#