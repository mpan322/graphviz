# graphviz, chapter 2
#
# DO NOT EDIT THIS FILE - EDIT EXAMPLES IN THE SOURCE INSTEAD!
#
# This file has been generated by AutoDoc. It contains examples extracted from
# the package documentation. Each example is preceded by a comment which gives
# the name of a GAPDoc XML file and a line range from which the example were
# taken. Note that the XML file in turn may have been generated by AutoDoc
# from some other input.
#
gap> START_TEST("graphviz01.tst");

# doc/_Chapter_Full_Reference.xml:78-89
gap> gv := GraphvizGraph("GraphyMcGraphFace");
<graphviz graph "GraphyMcGraphFace" with 0 nodes and 0 edges>
gap> GraphvizName(gv);
"GraphyMcGraphFace"
gap> GraphvizGraph(666);
<graphviz graph "666" with 0 nodes and 0 edges>
gap> gv := GraphvizGraph();
<graphviz graph with 0 nodes and 0 edges>
gap> GraphvizName(gv);
""

# doc/_Chapter_Full_Reference.xml:131-142
gap> gv := GraphvizDigraph("GraphyMcGraphFace");
<graphviz digraph "GraphyMcGraphFace" with 0 nodes and 0 edges>
gap> GraphvizName(gv);
"GraphyMcGraphFace"
gap> GraphvizDigraph(666);
<graphviz digraph "666" with 0 nodes and 0 edges>
gap> gv := GraphvizDigraph();
<graphviz digraph with 0 nodes and 0 edges>
gap> GraphvizName(gv);
""

# doc/_Chapter_Full_Reference.xml:167-177
gap> dot := GraphvizDigraph("The Round Table");;
gap> GraphvizName(dot);
"The Round Table"
gap> n := GraphvizSetAttr(GraphvizAddNode(dot, "A"), "label", "King Arthur");
gap> GraphvizName(n);
"A"
gap> e := GraphvizAddEdge(dot, "A", "B");;
gap> GraphvizName(e);
"(A, B)"

# doc/_Chapter_Full_Reference.xml:196-198
gap>

# doc/_Chapter_Full_Reference.xml:211-213
gap>

# doc/_Chapter_Full_Reference.xml:227-229
gap>

# doc/_Chapter_Full_Reference.xml:245-247
gap>

# doc/_Chapter_Full_Reference.xml:264-266
gap>

# doc/_Chapter_Full_Reference.xml:287-289
gap>

# doc/_Chapter_Full_Reference.xml:302-304
gap>

# doc/_Chapter_Full_Reference.xml:331-333
gap>

# doc/_Chapter_Full_Reference.xml:347-349
gap>

# doc/_Chapter_Full_Reference.xml:367-369
gap>

# doc/_Chapter_Full_Reference.xml:387-389
gap>

# doc/_Chapter_Full_Reference.xml:416-418
gap>

# doc/_Chapter_Full_Reference.xml:437-439
gap>

# doc/_Chapter_Full_Reference.xml:452-454
gap>

# doc/_Chapter_Full_Reference.xml:469-471
gap>

# doc/_Chapter_Full_Reference.xml:497-499
gap>

# doc/_Chapter_Full_Reference.xml:516-518
gap>

# doc/_Chapter_Full_Reference.xml:537-539
gap>

# doc/_Chapter_Full_Reference.xml:553-555
gap>

# doc/_Chapter_Full_Reference.xml:661-663
gap>

# doc/_Chapter_Full_Reference.xml:680-682
gap>

# doc/_Chapter_Full_Reference.xml:697-699
gap>

# doc/_Chapter_Full_Reference.xml:714-716
gap>

# doc/_Chapter_Full_Reference.xml:730-732
gap>

# doc/_Chapter_Full_Reference.xml:746-748
gap>

#
gap> STOP_TEST("graphviz01.tst", 1);
