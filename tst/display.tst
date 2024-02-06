#############################################################################
##
#W  standard/display.tst
#Y  Copyright (C) 2014-15                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##  Taken from the old digraphs display package
##
#############################################################################
##
gap> START_TEST("Digraphs package: standard/display.tst");
gap> LoadPackage("digraphs", false);;

#
gap> DIGRAPHS_StartTest();

#  DotDigraph and DotSymmetricDigraph
gap> r := rec(DigraphVertices := [1 .. 3], DigraphSource := [1, 1, 1, 1],
> DigraphRange := [1, 2, 2, 3]);;
gap> gr := Digraph(r);;
gap> dot := GV_DotDigraph(gr);;
gap> GV_String(dot);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1\n\t2\n\t3\n\t1 -> 3\n\t1 -> 2\
\n\t1 -> 2\n\t1 -> 1\n}\n"
gap> r := rec(DigraphVertices := [1 .. 8],
> DigraphSource := [1, 1, 2, 2, 3, 4, 4, 4, 5, 5, 5, 5, 5, 6, 7, 7, 7, 7, 7, 8,
>                   8],
> DigraphRange  := [6, 7, 1, 6, 5, 1, 4, 8, 1, 3, 6, 6, 7, 7, 1, 4, 4, 5, 7, 5,
>                   6]);;
gap> gr1 := Digraph(r);;
gap> dot1 := GV_DotDigraph(gr1);;
gap> GV_String(dot1);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1\n\t2\n\t3\n\t4\n\t5\n\t6\n\t7\
\n\t8\n\t8 -> 6\n\t8 -> 5\n\t7 -> 7\n\t7 -> 5\n\t7 -> 4\n\t7 -> 4\n\t7 -> 1\n\
\t6 -> 7\n\t5 -> 7\n\t5 -> 6\n\t5 -> 6\n\t5 -> 3\n\t5 -> 1\n\t4 -> 8\n\t4 -> 4\
\n\t4 -> 1\n\t3 -> 5\n\t2 -> 6\n\t2 -> 1\n\t1 -> 7\n\t1 -> 6\n}\n"
gap> adj := [[2], [1, 3], [2, 3, 4], [3]];
[ [ 2 ], [ 1, 3 ], [ 2, 3, 4 ], [ 3 ] ]
gap> gr2 := Digraph(adj);;
gap> dot2 := GV_DotDigraph(gr2);;
gap> GV_String(dot2);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1\n\t2\n\t3\n\t4\n\t4 -> 3\n\t3 \
-> 4\n\t3 -> 3\n\t3 -> 2\n\t2 -> 3\n\t2 -> 1\n\t1 -> 2\n}\n"
gap> dot3 := GV_DotSymmetricDigraph(gr2);;
gap> GV_String(dot3);
"graph hgn {\n\tnode [shape=\"circle\"] \n\t1\n\t2\n\t3\n\t4\n\t3 -- 4\n\t3 --\
 3\n\t2 -- 3\n\t1 -- 2\n}\n"

#DotColoredDigraph and DotSymmetriColoredDigraph
gap> D := CompleteDigraph(4);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";; 
gap> vertcolors[3] := "green";; vertcolors[4] := "yellow";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];; 
gap> edgecolors[1][1] := "lightblue";;
gap> edgecolors[1][2] := "pink";;
gap> edgecolors[1][3] := "purple";;
gap> edgecolors[2][1] := "lightblue";;
gap> edgecolors[2][2] := "pink";; 
gap> edgecolors[2][3] := "purple";; 
gap> edgecolors[3][1] := "lightblue";; 
gap> edgecolors[3][2] := "pink";; 
gap> edgecolors[3][3] := "purple";;
gap> edgecolors[4][1] := "lightblue";; 
gap> edgecolors[4][2] := "pink";;
gap> edgecolors[4][3] := "purple";;
gap> dot1 := GV_DotColoredDigraph(D, vertcolors, edgecolors);;
gap> GV_String(dot1);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"fille\
d\"]\n\t2 [color=\"red\", style=\"filled\"]\n\t3 [color=\"green\", style=\"fil\
led\"]\n\t4 [color=\"yellow\", style=\"filled\"]\n\t4 -> 3 [color=\"purple\"]\
\n\t4 -> 2 [color=\"pink\"]\n\t4 -> 1 [color=\"lightblue\"]\n\t3 -> 4 [color=\
\"purple\"]\n\t3 -> 2 [color=\"pink\"]\n\t3 -> 1 [color=\"lightblue\"]\n\t2 ->\
 4 [color=\"purple\"]\n\t2 -> 3 [color=\"pink\"]\n\t2 -> 1 [color=\"lightblue\
\"]\n\t1 -> 4 [color=\"purple\"]\n\t1 -> 3 [color=\"pink\"]\n\t1 -> 2 [color=\
\"lightblue\"]\n}\n"
gap> D := Digraph([[2], [1, 3], [2]]);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";;
gap> vertcolors[2] := "pink";;
gap> vertcolors[3] := "purple";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];;
gap> edgecolors[1][1] := "green";;
gap> edgecolors[2][1] := "green";;
gap> edgecolors[3][1] := "red";; edgecolors[2][2] := "red";;
gap> dot2 := GV_DotSymmetricColoredDigraph(D, vertcolors, edgecolors);;
gap> GV_String(dot2);
"graph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"filled\
\"]\n\t2 [color=\"pink\", style=\"filled\"]\n\t3 [color=\"purple\", style=\"fi\
lled\"]\n\t2 -- 3 [color=\"red\"]\n\t1 -- 2 [color=\"green\"]\n}\n"
gap> D := Digraph([[2, 3], [1, 3], [1]]);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";;
gap> vertcolors[3] := "green";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];;
gap> edgecolors[1][1] := "orange";; edgecolors[1][2] := "yellow";;
gap> edgecolors[2][1] := "orange";; edgecolors[2][2] := "pink";;
gap> edgecolors[3][1] := "yellow";;
gap> dot3 := GV_DotColoredDigraph(D, vertcolors, edgecolors);;
gap> GV_String(dot3);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"fille\
d\"]\n\t2 [color=\"red\", style=\"filled\"]\n\t3 [color=\"green\", style=\"fil\
led\"]\n\t3 -> 1 [color=\"yellow\"]\n\t2 -> 3 [color=\"pink\"]\n\t2 -> 1 [colo\
r=\"orange\"]\n\t1 -> 3 [color=\"yellow\"]\n\t1 -> 2 [color=\"orange\"]\n}\n"
gap> D := Digraph(IsMutableDigraph, [[2, 3], [1, 3], [1]]);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";;
gap> vertcolors[3] := "green";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];;
gap> edgecolors[1][1] := "orange";; edgecolors[1][2] := "yellow";;
gap> edgecolors[2][1] := "orange";; edgecolors[2][2] := "pink";;
gap> edgecolors[3][1] := "yellow";;
gap> dot4 := GV_DotColoredDigraph(D, vertcolors, edgecolors);;
gap> GV_String(dot4);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"fille\
d\"]\n\t2 [color=\"red\", style=\"filled\"]\n\t3 [color=\"green\", style=\"fil\
led\"]\n\t3 -> 1 [color=\"yellow\"]\n\t2 -> 3 [color=\"pink\"]\n\t2 -> 1 [colo\
r=\"orange\"]\n\t1 -> 3 [color=\"yellow\"]\n\t1 -> 2 [color=\"orange\"]\n}\n"
gap> D := Digraph([[2, 4], [1, 3], [2], [1]]);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";;
gap> vertcolors[3] := "green";; vertcolors[4] := "yellow";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];;
gap> edgecolors[1][1] := "orange";; edgecolors[1][2] := "orange";;
gap> edgecolors[2][1] := "orange";; edgecolors[2][2] := "orange";;
gap> edgecolors[3][1] := "orange";; edgecolors[4][1] := "orange";;
gap> dot5 := GV_DotSymmetricColoredDigraph(D, vertcolors, edgecolors);;
gap> GV_String(dot5);
"graph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"filled\
\"]\n\t2 [color=\"red\", style=\"filled\"]\n\t3 [color=\"green\", style=\"fill\
ed\"]\n\t4 [color=\"yellow\", style=\"filled\"]\n\t2 -- 3 [color=\"orange\"]\n\
\t1 -- 4 [color=\"orange\"]\n\t1 -- 2 [color=\"orange\"]\n}\n"
gap> D := Digraph(IsMutableDigraph, [[2, 4], [1, 3], [2], [1]]);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";;
gap> vertcolors[3] := "green";; vertcolors[4] := "yellow";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];;
gap> edgecolors[1][1] := "orange";; edgecolors[1][2] := "orange";;
gap> edgecolors[2][1] := "orange";; edgecolors[2][2] := "orange";;
gap> edgecolors[3][1] := "orange";; edgecolors[4][1] := "orange";;
gap> dot6 := GV_DotSymmetricColoredDigraph(D, vertcolors, edgecolors);;
gap> GV_String(dot6);
"graph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"filled\
\"]\n\t2 [color=\"red\", style=\"filled\"]\n\t3 [color=\"green\", style=\"fill\
ed\"]\n\t4 [color=\"yellow\", style=\"filled\"]\n\t2 -- 3 [color=\"orange\"]\n\
\t1 -- 4 [color=\"orange\"]\n\t1 -- 2 [color=\"orange\"]\n}\n"
gap> D := CompleteDigraph(4);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "banana";; 
gap> vertcolors[3] := "green";; vertcolors[4] := "yellow";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];; 
gap> edgecolors[1][1] := "lightblue";;
gap> edgecolors[1][2] := "pink";;
gap> edgecolors[1][3] := "purple";;
gap> edgecolors[2][1] := "lightblue";;
gap> edgecolors[2][2] := "pink";; 
gap> edgecolors[2][3] := "purple";; 
gap> edgecolors[3][1] := "lightblue";; 
gap> edgecolors[3][2] := "pink";; 
gap> edgecolors[3][3] := "purple";;
gap> edgecolors[4][1] := "lightblue";; 
gap> edgecolors[4][2] := "pink";;
gap> edgecolors[4][3] := "purple";;
gap> GV_DotColoredDigraph(D, vertcolors, edgecolors){[5 .. 35]};
Error, expected RGB Value or valid color name as defined by GraphViz 2.44.1 X1\
1 Color Scheme http://graphviz.org/doc/info/colors.html
gap> D := CompleteDigraph(4);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";; 
gap> vertcolors[3] := "green";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];; 
gap> edgecolors[1][1] := "lightblue";;
gap> edgecolors[1][2] := "pink";;
gap> edgecolors[1][3] := "purple";;
gap> edgecolors[2][1] := "lightblue";;
gap> edgecolors[2][2] := "pink";; 
gap> edgecolors[2][3] := "purple";; 
gap> edgecolors[3][1] := "lightblue";; 
gap> edgecolors[3][2] := "pink";; 
gap> edgecolors[3][3] := "purple";;
gap> edgecolors[4][1] := "lightblue";; 
gap> edgecolors[4][2] := "pink";;
gap> edgecolors[4][3] := "purple";;
gap> GV_DotColoredDigraph(D, vertcolors, edgecolors);
Error, the number of vertex colors must be the same as the number of vertices,\
 expected 4 but found 3
gap> D := CompleteDigraph(4);;
gap> vertcolors := [];;
gap> vertcolors[1] := 2;; vertcolors[2] := 1;; 
gap> vertcolors[3] := 1;; vertcolors[4] := 3;;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];; 
gap> edgecolors[1][1] := "lightblue";;
gap> edgecolors[1][2] := "pink";;
gap> edgecolors[1][3] := "purple";;
gap> edgecolors[2][1] := "lightblue";;
gap> edgecolors[2][2] := "pink";; 
gap> edgecolors[2][3] := "purple";; 
gap> edgecolors[3][1] := "lightblue";; 
gap> edgecolors[3][2] := "pink";; 
gap> edgecolors[3][3] := "purple";;
gap> edgecolors[4][1] := "lightblue";; 
gap> edgecolors[4][2] := "pink";;
gap> edgecolors[4][3] := "purple";;
gap> GV_DotColoredDigraph(D, vertcolors, edgecolors);
Error, expected a string
gap> D := CompleteDigraph(4);;
gap> vertcolors := [];;
gap> vertcolors[1] := "#AB3487";; vertcolors[2] := "#DF4738";; 
gap> vertcolors[3] := "#4BF234";; vertcolors[4] := "#AF34C9";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];; 
gap> edgecolors[1][1] := "lightblue";;
gap> edgecolors[1][2] := "pink";;
gap> edgecolors[1][3] := "purple";;
gap> edgecolors[2][1] := "lightblue";;
gap> edgecolors[2][2] := "pink";; 
gap> edgecolors[2][3] := "purple";; 
gap> edgecolors[3][1] := "lightblue";; 
gap> edgecolors[3][2] := "pink";; 
gap> edgecolors[3][3] := "purple";;
gap> edgecolors[4][1] := "lightblue";; 
gap> edgecolors[4][2] := "pink";;
gap> edgecolors[4][3] := "purple";;
gap> x1 := GV_DotColoredDigraph(D, vertcolors, edgecolors);;
gap> GV_String(x1);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"#AB3487\", style=\"fi\
lled\"]\n\t2 [color=\"#DF4738\", style=\"filled\"]\n\t3 [color=\"#4BF234\", st\
yle=\"filled\"]\n\t4 [color=\"#AF34C9\", style=\"filled\"]\n\t4 -> 3 [color=\"\
purple\"]\n\t4 -> 2 [color=\"pink\"]\n\t4 -> 1 [color=\"lightblue\"]\n\t3 -> 4\
 [color=\"purple\"]\n\t3 -> 2 [color=\"pink\"]\n\t3 -> 1 [color=\"lightblue\"]\
\n\t2 -> 4 [color=\"purple\"]\n\t2 -> 3 [color=\"pink\"]\n\t2 -> 1 [color=\"li\
ghtblue\"]\n\t1 -> 4 [color=\"purple\"]\n\t1 -> 3 [color=\"pink\"]\n\t1 -> 2 [\
color=\"lightblue\"]\n}\n"
gap> D := CompleteDigraph(4);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";; 
gap> vertcolors[3] := "green";; vertcolors[4] := "yellow";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];; 
gap> edgecolors[1][1] := "banana";;
gap> edgecolors[1][2] := "pink";;
gap> edgecolors[1][3] := "purple";;
gap> edgecolors[2][1] := "lightblue";;
gap> edgecolors[2][2] := "pink";; 
gap> edgecolors[2][3] := "purple";; 
gap> edgecolors[3][1] := "cherry";; 
gap> edgecolors[3][2] := "pink";; 
gap> edgecolors[3][3] := "purple";;
gap> edgecolors[4][1] := "lightblue";; 
gap> edgecolors[4][2] := "pink";;
gap> edgecolors[4][3] := "purple";;
gap> GV_DotColoredDigraph(D, vertcolors, edgecolors);
Error, expected RGB Value or valid color name as defined by GraphViz 2.44.1 X1\
1 Color Scheme http://graphviz.org/doc/info/colors.html
gap> D := CompleteDigraph(4);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";; 
gap> vertcolors[3] := "green";; vertcolors[4] := "yellow";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];; 
gap> edgecolors[1][1] := "lightblue";;
gap> edgecolors[1][2] := "pink";;
gap> edgecolors[1][3] := "purple";;
gap> edgecolors[2][1] := "lightblue";;
gap> edgecolors[2][2] := "pink";; 
gap> edgecolors[2][3] := "purple";; 
gap> edgecolors[3][1] := "lightblue";; 
gap> edgecolors[3][2] := "pink";; 
gap> edgecolors[3][3] := "purple";;
gap> edgecolors[4][1] := "lightblue";; 
gap> edgecolors[4][2] := "pink";;
gap> GV_DotColoredDigraph(D, vertcolors, edgecolors);
Error, the list of edge colors needs to have the same shape as the out-neighbo\
urs of the digraph

# DotVertexColoredDigraph
gap> D := CompleteDigraph(4);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";; 
gap> vertcolors[3] := "green";; vertcolors[4] := "yellow";;
gap> out1 := GV_DotVertexColoredDigraph(D, vertcolors);;
gap> GV_String(out1);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"fille\
d\"]\n\t2 [color=\"red\", style=\"filled\"]\n\t3 [color=\"green\", style=\"fil\
led\"]\n\t4 [color=\"yellow\", style=\"filled\"]\n\t4 -> 3\n\t4 -> 2\n\t4 -> 1\
\n\t3 -> 4\n\t3 -> 2\n\t3 -> 1\n\t2 -> 4\n\t2 -> 3\n\t2 -> 1\n\t1 -> 4\n\t1 ->\
 3\n\t1 -> 2\n}\n"
gap> D := EmptyDigraph(3);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";; vertcolors[2] := "red";;
gap> vertcolors[3] := "green";;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];; 
gap> edgecolors[3] := [];;
gap> out2 := GV_DotVertexColoredDigraph(D, vertcolors);;
gap> GV_String(out2);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"fille\
d\"]\n\t2 [color=\"red\", style=\"filled\"]\n\t3 [color=\"green\", style=\"fil\
led\"]\n}\n"

# DotEdgeColoredDigraph
gap> D := CompleteDigraph(4);;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];; edgecolors[4] := [];; 
gap> edgecolors[1][1] := "lightblue";;
gap> edgecolors[1][2] := "pink";;
gap> edgecolors[1][3] := "purple";;
gap> edgecolors[2][1] := "lightblue";;
gap> edgecolors[2][2] := "pink";; 
gap> edgecolors[2][3] := "purple";; 
gap> edgecolors[3][1] := "lightblue";; 
gap> edgecolors[3][2] := "pink";; 
gap> edgecolors[3][3] := "purple";;
gap> edgecolors[4][1] := "lightblue";; 
gap> edgecolors[4][2] := "pink";;
gap> edgecolors[4][3] := "purple";;
gap> out1 := GV_DotEdgeColoredDigraph(D, edgecolors);;
gap> GV_String(out1);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1\n\t2\n\t3\n\t4\n\t4 -> 3 [colo\
r=\"purple\"]\n\t4 -> 2 [color=\"pink\"]\n\t4 -> 1 [color=\"lightblue\"]\n\t3 \
-> 4 [color=\"purple\"]\n\t3 -> 2 [color=\"pink\"]\n\t3 -> 1 [color=\"lightblu\
e\"]\n\t2 -> 4 [color=\"purple\"]\n\t2 -> 3 [color=\"pink\"]\n\t2 -> 1 [color=\
\"lightblue\"]\n\t1 -> 4 [color=\"purple\"]\n\t1 -> 3 [color=\"pink\"]\n\t1 ->\
 2 [color=\"lightblue\"]\n}\n"
gap> GV_DotEdgeColoredDigraph(CycleDigraph(3), []);
Error, the list of edge colors needs to have the same shape as the out-neighbo\
urs of the digraph
gap> GV_DotEdgeColoredDigraph(CycleDigraph(3), [[fail, fail], [fail], [fail]]);
Error, the list of edge colors needs to have the same shape as the out-neighbo\
urs of the digraph
gap> GV_DotEdgeColoredDigraph(CycleDigraph(3), [[fail], [fail], [fail]]);
Error, expected a string

# DotSymmetricVertexColoredDigraph
gap> D := Digraph([[2], [1, 3], [2]]);;
gap> vertcolors := [];;
gap> vertcolors[1] := "blue";;
gap> vertcolors[2] := "pink";;
gap> vertcolors[3] := "purple";;
gap> out1 := GV_DotSymmetricVertexColoredDigraph(D, vertcolors);;
gap> GV_String(out1);
"graph hgn {\n\tnode [shape=\"circle\"] \n\t1 [color=\"blue\", style=\"filled\
\"]\n\t2 [color=\"pink\", style=\"filled\"]\n\t3 [color=\"purple\", style=\"fi\
lled\"]\n\t2 -- 3\n\t1 -- 2\n}\n"

# DotSymmetricEdgeColoredDigraph
gap> D := Digraph([[2], [1, 3], [2]]);;
gap> edgecolors := [];;
gap> edgecolors[1] := [];; edgecolors[2] := [];;
gap> edgecolors[3] := [];;
gap> edgecolors[1][1] := "green";; edgecolors[2][1] := "green";;
gap> edgecolors[2][2] := "red";; edgecolors[3][1] := "red";;
gap> out1 := GV_DotSymmetricEdgeColoredDigraph(D, edgecolors);;
gap> GV_String(out1);
"graph hgn {\n\tnode [shape=\"circle\"] \n\t1\n\t2\n\t3\n\t2 -- 3 [color=\"red\
\"]\n\t1 -- 2 [color=\"green\"]\n}\n"

# DotVertexLabelledDigraph
gap> r := rec(DigraphVertices := [1 .. 3], DigraphSource := [1, 1, 1, 1],
> DigraphRange := [1, 2, 2, 3]);;
gap> gr := Digraph(r);;
gap> dot1 := GV_DotVertexLabelledDigraph(gr);;
gap> GV_String(dot1);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1 [label=\"1\"]\n\t2 [label=\"2\
\"]\n\t3 [label=\"3\"]\n\t1 -> 3\n\t1 -> 2\n\t1 -> 2\n\t1 -> 1\n}\n"
gap> SetDigraphVertexLabel(gr, 1, 2);
gap> dot2 := GV_DotVertexLabelledDigraph(gr);;
gap> GV_String(dot2);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1 [label=\"2\"]\n\t2 [label=\"2\
\"]\n\t3 [label=\"3\"]\n\t1 -> 3\n\t1 -> 2\n\t1 -> 2\n\t1 -> 1\n}\n"

# Splash 
gap> Splash(1);
Error, the 1st argument must be a string,
gap> Splash("string", 0);
Error, the 2nd argument must be a record,
gap> Splash("string");
Error, the component "type" of the 2nd argument <a record>  must be "dot" or "\
latex",
gap> Splash("string", rec(path := "~/", filename := "filename"));
Error, the component "type" of the 2nd argument <a record>  must be "dot" or "\
latex",
gap> Splash("string", rec(viewer := "xpdf"));
Error, the viewer "xpdf" specified in the option `viewer` is not available,
gap> Splash("string", rec(type := "dot", engine := "dott"));
Error, the component "engine" of the 2nd argument <a record> must be one of: "\
dot", "neato", "twopi", "circo", "fdp", "sfdp", or "patchwork"
gap> tmpdir := Filename(DirectoryTemporary(), "");;
gap> Splash("string",
> rec(path      := tmpdir,
>     directory := "digraphs_temporary_directory"));
Error, the component "type" of the 2nd argument <a record>  must be "dot" or "\
latex",
gap> Splash("%latex", rec(filetype := "latex", engine := fail));
Error, the component "engine" of the 2nd argument <a record> must be one of: "\
dot", "neato", "twopi", "circo", "fdp", "sfdp", or "patchwork"
gap> Splash("//dot", rec(filetype := "pdf", engine := fail));
Error, the component "engine" of the 2nd argument <a record> must be one of: "\
dot", "neato", "twopi", "circo", "fdp", "sfdp", or "patchwork"
gap> MakeReadWriteGlobal("VizViewers");
gap> VizViewers_backup := ShallowCopy(VizViewers);;
gap> VizViewers := ["nonexistent-viewer"];;
gap> Splash("//dot");
Error, none of the default viewers [ "nonexistent-viewer" 
 ] is available, please specify an available viewer in the options record comp\
onent `viewer`,
gap> VizViewers := VizViewers_backup;;
gap> MakeReadOnlyGlobal("VizViewers");
gap> Splash(DotDigraph(RandomDigraph(10)), rec(viewer := 1));
Error, the option `viewer` must be a string, not an integer,
gap> Splash(DotDigraph(RandomDigraph(10)), rec(viewer := "asdfasfa"));
Error, the viewer "asdfasfa" specified in the option `viewer` is not available\
,

# DotPartialOrderDigraph
gap> gr := Digraph([[1], [1, 2], [1, 3], [1, 4], [1 .. 5], [1 .. 6],
> [1, 2, 3, 4, 5, 7], [1, 8]]);;
gap> out1 := GV_DotPartialOrderDigraph(gr);;
gap> GV_String(out1);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1\n\t2\n\t3\n\t4\n\t5\n\t6\n\t7\
\n\t8\n\t8 -> 1\n\t7 -> 5\n\t6 -> 5\n\t5 -> 4\n\t5 -> 3\n\t5 -> 2\n\t4 -> 1\n\
\t3 -> 1\n\t2 -> 1\n}\n"
gap> gr := Digraph([[1], [2], [1, 3], [2, 4], [1, 2, 3, 4, 5], [1, 2, 3, 6]]);;
gap> out2 := GV_DotPartialOrderDigraph(gr);;
gap> GV_String(out2);
"digraph hgn {\n\tnode [shape=\"circle\"] \n\t1\n\t2\n\t3\n\t4\n\t5\n\t6\n\t6 \
-> 2\n\t6 -> 3\n\t5 -> 4\n\t5 -> 3\n\t4 -> 2\n\t3 -> 1\n}\n"
gap> gr := Digraph([[1], []]);;
gap> GV_DotPartialOrderDigraph(gr);;
Error, the argument <D> must be a partial order digraph,

#
gap> DIGRAPHS_StopTest();
gap> STOP_TEST("Digraphs package: standard/display.tst", 0);

# DotPreorderDigraph and DotQuasiorderDigraph
gap> GV_DotPreorderDigraph(CompleteDigraph(5));;
Error, the argument <D> must be a preorder digraph,
gap> gr := Digraph([[1], [1, 2], [1, 3], [1, 4], [1 .. 5], [1 .. 6],
> [1, 2, 3, 4, 5, 7], [1, 8]]);;
gap> out1 := GV_DotPreorderDigraph(gr);;
gap> GV_String(out1);
"digraph graphname {\n\tnode [shape=\"Mrecord\"] height=\"0.5\" fixedsize=\"tr\
ue\" ranksep=\"1\" \n\t1 [label=\"1\", width=\"0.5\"]\n\t2 [label=\"2\", width\
=\"0.5\"]\n\t3 [label=\"3\", width=\"0.5\"]\n\t4 [label=\"4\", width=\"0.5\"]\
\n\t5 [label=\"5\", width=\"0.5\"]\n\t6 [label=\"6\", width=\"0.5\"]\n\t7 [lab\
el=\"7\", width=\"0.5\"]\n\t8 [label=\"8\", width=\"0.5\"]\n\t8 -> 1\n\t7 -> 5\
\n\t6 -> 5\n\t5 -> 4\n\t5 -> 3\n\t5 -> 2\n\t4 -> 1\n\t3 -> 1\n\t2 -> 1\n}\n"
gap> gr := Concatenation("&X_?_A]|^Vr[nHpmVcy~zy[A????_???G??B]nhtmvcwvJq\\^~",
> "|m??_AEx]Rb[nHo??__vJy[??A??O_aV~^Zb]njo???_???GZdxMLy}n_");;
gap> gr := DigraphFromDigraph6String(gr);;
gap> out2 := GV_DotPreorderDigraph(gr);;
gap> GV_String(out2);
"digraph graphname {\n\tnode [shape=\"Mrecord\"] height=\"0.5\" fixedsize=\"tr\
ue\" ranksep=\"1\" \n\t1 [label=\"23\", width=\"0.5\"]\n\t10 [label=\"4|3|15|1\
4|11|24\", width=\"3.\"]\n\t11 [label=\"17\", width=\"0.5\"]\n\t12 [label=\"9\
\", width=\"0.5\"]\n\t13 [label=\"21\", width=\"0.5\"]\n\t14 [label=\"25\", wi\
dth=\"0.5\"]\n\t15 [label=\"2\", width=\"0.5\"]\n\t16 [label=\"10\", width=\"0\
.5\"]\n\t17 [label=\"5\", width=\"0.5\"]\n\t18 [label=\"20\", width=\"0.5\"]\n\
\t19 [label=\"12\", width=\"0.5\"]\n\t2 [label=\"13\", width=\"0.5\"]\n\t20 [l\
abel=\"18\", width=\"0.5\"]\n\t3 [label=\"1\", width=\"0.5\"]\n\t4 [label=\"8\
\", width=\"0.5\"]\n\t5 [label=\"7\", width=\"0.5\"]\n\t6 [label=\"6\", width=\
\"0.5\"]\n\t7 [label=\"22\", width=\"0.5\"]\n\t8 [label=\"16\", width=\"0.5\"]\
\n\t9 [label=\"19\", width=\"0.5\"]\n\t19 -> 18\n\t18 -> 17\n\t17 -> 12\n\t17 \
-> 16\n\t16 -> 10\n\t16 -> 3\n\t15 -> 14\n\t15 -> 3\n\t14 -> 13\n\t13 -> 12\n\
\t12 -> 11\n\t11 -> 10\n\t10 -> 8\n\t10 -> 6\n\t10 -> 5\n\t10 -> 9\n\t9 -> 4\n\
\t9 -> 2\n\t8 -> 7\n\t3 -> 2\n\t2 -> 1\n}\n"
gap> gr := DigraphDisjointUnion(CompleteDigraph(10),
>                               CompleteDigraph(5),
>                               CycleDigraph(2));;
gap> gr := DigraphReflexiveTransitiveClosure(DigraphAddEdge(gr, [10, 11]));;
gap> IsPreorderDigraph(gr);
true
gap> out3 := GV_DotPreorderDigraph(gr);;
gap> GV_String(out3);
"digraph graphname {\n\tnode [shape=\"Mrecord\"] height=\"0.5\" fixedsize=\"tr\
ue\" ranksep=\"1\" \n\t1 [label=\"11|12|13|14|15\", width=\"2.5\"]\n\t2 [label\
=\"1|2|3|4|5|6|7|8|9|10\", width=\"5.\"]\n\t3 [label=\"16|17\", width=\"1.\"]\
\n\t2 -> 1\n}\n"

# DotHighlightedDigraph
gap> gr := Digraph([[2, 3], [2], [1, 3]]);;
gap> out1 := GV_DotHighlightedDigraph(gr, [1, 2], "red", "black");;
gap> GV_String(out1);
"digraph hgn {\n\t1 [color=\"red\", shape=\"circle\"]\n\t2 [color=\"red\", sha\
pe=\"circle\"]\n\t3 [color=\"black\", shape=\"circle\"]\n\t2 -> 2 [color=\"red\
\"]\n\t1 -> 3 [color=\"black\"]\n\t1 -> 2 [color=\"red\"]\n\t3 -> 3 [color=\"b\
lack\"]\n\t3 -> 1 [color=\"black\"]\n}\n"
gap> D := CycleDigraph(5);;
gap> DotHighlightedDigraph(D, [10], "black", "grey");
Error, the 2nd argument <highverts> must be a list of vertices of the 1st argu\
ment <D>,
gap> DotHighlightedDigraph(D, [1], "", "grey");
Error, the 3rd argument <highcolour> must be a string containing the name of a\
 colour,
gap> DotHighlightedDigraph(D, [1], "black", "");
Error, the 4th argument <lowcolour> must be a string containing the name of a \
colour,
gap> out2 := GV_DotHighlightedDigraph(D, Filtered(DigraphVertices(D), IsEvenInt));;
gap> GV_String(out2);
"digraph hgn {\n\t1 [color=\"grey\", shape=\"circle\"]\n\t2 [color=\"black\", \
shape=\"circle\"]\n\t3 [color=\"grey\", shape=\"circle\"]\n\t4 [color=\"black\
\", shape=\"circle\"]\n\t5 [color=\"grey\", shape=\"circle\"]\n\t4 -> 5 [color\
=\"grey\"]\n\t2 -> 3 [color=\"grey\"]\n\t5 -> 1 [color=\"grey\"]\n\t3 -> 4 [co\
lor=\"grey\"]\n\t1 -> 2 [color=\"grey\"]\n}\n"

#
gap> DIGRAPHS_StopTest();
gap> STOP_TEST("Digraphs package: standard/display.tst", 0);