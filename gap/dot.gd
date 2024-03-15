#! @Chapter
#! @ChapterTitle An introduction to the DOT language and Graphviz.
#! This chapter explains what the DOT and graphviz are, 
#! key basic concepts relating to them, and how this package interacts with them.

#! @Section A Brief Introduction
#! DOT is a language for descrbing to a computer how to display a visualization for a graph or digraph.
#! Graphviz is a graph vizualization software which can consume DOT and produce vizual outputs.
#! This package is designed to allow users to programmatically construct objects in GAP which can then be converted into DOT.
#! That DOT can then be inputted into the graphviz software to produce a visual output.
#! As DOT is central to the design of this package it will likely be helpful to have a basic understanding of the language.
#! For more information about DOT see <URL>https://graphviz.org/doc/info/lang.html</URL>.

#! @Chapter
#! @ChapterTitle The Graphviz Package

#! @Section Graphviz Categories

#! @BeginGroup Filters
#! @Description Every object in graphviz belongs to the IsGVObject category. 
#! The categories following it are for further specificity on the type of objects.
#! These are graphs, digraphs, nodes and edges respectively.
#! All are direct subcategories of IsGVObject excluding IsGVDigraph which is a subcategory of is GVGraph. 
DeclareCategory("IsGVObject", IsObject); 
DeclareCategory("IsGVGraph", IsGVObject);
DeclareCategory("IsGVDigraph", IsGVGraph);
DeclareCategory("IsGVContext", IsGVGraph);
DeclareCategory("IsGVNode", IsGVObject);
DeclareCategory("IsGVEdge", IsGVObject);
#! @EndGroup

#! @Section Constructors

#! @BeginGroup
#! @GroupTitle Getting a node from a graph
#! @Arguments graph, node name
#! @Returns the graphviz node with that name 
#! @Description 
#! Gets a graphviz node from a graph. 
DeclareOperation("\[\]", [IsGVGraph, IsObject]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Getting an attribute of a node
#! @Arguments node, attribute name name
#! @Returns the value of the attribute 
#! @Description 
#! Gets an attribute from a node. 
DeclareOperation("\[\]\:\=", [IsGVNode, IsObject, IsObject]);
DeclareOperation("\[\]", [IsGVNode, IsObject]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Getting an attribute of a node
#! @Arguments edge, attribute name
#! @Returns the the value of the attribute 
#! @Description 
#! Gets an attribute from an edge. 
DeclareOperation("\[\]", [IsGVEdge, IsObject]);
DeclareOperation("\[\]\:\=", [IsGVEdge, IsObject, IsObject]);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Constructors for Graphs
#! @Arguments name
#! @Returns a new graphviz graph
#! @Description Creates a new graphviz graph optionally with the provided name.
DeclareOperation("GraphvizGraph", [IsObject]);
DeclareOperation("GraphvizGraph", []);
#! @EndGroup

#! @BeginGroup
#! @GroupTitle Constructors for Digraphs
#! @Arguments name
#! @Returns a new graphviz digraph
#! @Description Creates a new graphviz digraph optionally with the provided name.
DeclareOperation("GraphvizDigraph", [IsObject]);
DeclareOperation("GraphvizDigraph", []);
#! @EndGroup

#! @Section Get Operations
#! This section covers the operations for getting information about graphviz objects.

#! @Subsection For all graphviz objects. 

#! @Arguments obj
#! @Returns the name of the provided graphviz object
#! @Description Gets the name of the provided graphviz object.
DeclareOperation("GraphvizName", [IsGVObject]);


#! @Arguments obj
#! @Returns the attributes of the provided graphviz object
#! @Description Gets the attributes of the provided graphviz object.
DeclareOperation("GraphvizAttrs", [IsGVObject]);

#! @Subsection For only graphs and digraphs.

#! @Arguments graph
#! @Returns the nodes of the provided graphviz graph.
#! @Description Gets the nodes of the provided graphviz graph.
#! Node names can only be [a-zA-Z0-9_£] TODO check exact docs.
DeclareOperation("GraphvizNodes", [IsGVGraph]);

#! @Arguments graph
#! @Returns the subgraphs of the provided graphviz graph.
#! @Description gets the subgraphs of a provided graphviz graph.
DeclareOperation("GraphvizSubgraphs", [IsGVGraph]);
DeclareOperation("GraphvizGetSubgraph", [IsGVGraph, IsObject]);

#! @Arguments graph, name
#! @Returns a graph with the provided name.
#! @Description 
#! Searches through the tree of subgraphs connected to this subgraph for a graph with the provided name. 
#! It returns the graph if it exists. 
#! If no such graph exists then it will return fail.
DeclareOperation("GraphvizFindGraph", [IsGVGraph, IsObject]);

#! @Arguments graph
#! @Returns the edges of the provided graphviz graph.
#! @Description Gets the edges of the provided graphviz graph.
DeclareOperation("GraphvizEdges", [IsGVGraph]);

#! @Subsection For only edges.

#! @Arguments edge
#! @Returns the head of the provided graphviz edge.
#! @Description Gets the head of the provided graphviz graph.
DeclareOperation("GraphvizHead", [IsGVEdge]);

#! @Arguments edge
#! @Returns the head of the provided graphviz tail.
#! @Description Gets the tail of the provided graphviz graph.
DeclareOperation("GraphvizTail", [IsGVEdge]);

#! @Section Set Operations
#! This section covers operations for modifying graphviz objects.

#! @Subsection For modifying graphs.

#! @Arguments graph, name
#! @Returns the modified graph.
#! @Description Sets the name of a graphviz graph or digraph.
DeclareOperation("GraphvizSetName",[IsGVGraph, IsObject]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Adds a node to the graph.
#! If a node with the same name is already present the operation fails.
DeclareOperation("GraphvizAddNode", [IsGVGraph, IsObject]);

#! @Arguments graph, edge
#! @Returns the modified graph.
#! @Description Adds an edge to the graph.
#! If no nodes with the same name are in the graph then the edge's nodes will be added to the graph.
#! If different nodes with the same name are in the graph then the operation fails.
DeclareOperation("GraphvizAddEdge", [IsGVGraph, IsObject, IsObject]);

#! @Arguments graph, filter, name
#! @Returns the new subgraph.
#! @Description Adds a subgraph to a graph.
DeclareOperation("GraphvizAddSubgraph", [IsGVGraph, IsObject]);
DeclareOperation("GraphvizAddSubgraph", [IsGVGraph]);

#! @Arguments graph, filter, name
#! @Returns the new context.
#! @Description Adds a context to a graph.
DeclareOperation("GraphvizAddContext", [IsGVGraph, IsObject]);
DeclareOperation("GraphvizAddContext", [IsGVGraph]);

#! @Arguments graph, node
#! @Returns the modified graph.
#! @Description Removes the node from the graph.
DeclareOperation("GraphvizRemoveNode", [IsGVGraph, IsObject]);

#! @Arguments graph, predicate
#! @Returns the modified graph.
#! @Description Filters the graph's edges using the provided predicate.
DeclareOperation("GraphvizFilterEdges", [IsGVGraph, IsFunction]);

#! @Arguments graph, head_name, tail_name
#! @Returns the modified graph.
#! @Description Filters the graph's edges, removing edges between nodes with the specified names.
DeclareOperation("GraphvizFilterEnds", [IsGVGraph, IsObject, IsObject]);

#! @Subsection For modifying object attributes.

#! @Arguments obj, attrs
#! @Returns the modified object.
#! @Description 
#!    Updates the attribtues of the object.
#!    All current attributes remain.
#!    If an attribute already exists and a new value is provided, the old value will be overwritten.
DeclareOperation("GraphvizSetAttrs", [IsGVObject, IsRecord]);
DeclareOperation("GraphvizSetAttr", [IsGVObject, IsObject, IsObject]);
DeclareOperation("GraphvizSetAttr", [IsGVObject, IsObject]);

#! @Arguments obj, attr
#! @Returns the modified object.
#! @Description Removes an attribute from the object provided.
DeclareOperation("GraphvizRemoveAttr", [IsGVObject, IsObject]);

#! @Section Outputting
#! @Arguments graph
#! @Returns the dot representation of the graphviz object.
DeclareOperation("AsString", [IsGVGraph]);
