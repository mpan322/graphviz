
###############################################################################
# Private functionality
###############################################################################

DeclareOperation("GV_StringifyComment", [IsString]);
DeclareOperation("GV_StringifyGraphHead", [IsString]);
DeclareOperation("GV_StringifyDigraphHead", [IsString]);
DeclareOperation("GV_StringifyGraphEdge", [IsString, IsString, IsRecord]);
DeclareOperation("GV_StringifyDigraphEdge", [IsString, IsString, IsRecord]);
DeclareOperation("GV_StringifySubgraph", [IsString]);
DeclareOperation("GV_StringifyPlainSubgraph", [IsString]);
DeclareOperation("GV_StringifyNode", [IsString, IsRecord]);
DeclareOperation("GV_StringifyGraphAttrs", [IsRecord]);
DeclareOperation("GV_StringifyNodeEdgeAttrs", [IsRecord]);
DeclareOperation("GV_StringifySubgraphBegin", [IsString]);
DeclareOperation("GV_StringifySubgraphEnd", []);

BindGlobal("GV_Head",
function(x)
  Assert(1, IsGVObject(x));
  return x!.HeadFunc(GV_Name(x));
end);

###############################################################################
# Family + type
###############################################################################

BindGlobal("GV_ObjectFamily",
           NewFamily("GV_ObjectFamily",
                     IsGVObject));

BindGlobal("GV_GraphType", NewType(GV_ObjectFamily,
                                   IsGVGraph and
                                   IsComponentObjectRep and
                                   IsAttributeStoringRep));
BindGlobal("GV_DigraphType", NewType(GV_ObjectFamily,
                                     IsGVDigraph and
                                     IsComponentObjectRep and
                                     IsAttributeStoringRep));

###############################################################################
# Constuctors etc
###############################################################################

InstallMethod(GV_Graph, "for a record", [IsRecord],
function(attrs)
  local result;

  if not IsBound(attrs.name) then
    attrs.name := "";
  fi;

  # TODO other attrs
  result := Objectify(GV_GraphType,
                      rec(HeadFunc   := GV_StringifyGraphHead,
                          EdgeFunc   := GV_StringifyGraphEdge,
                          Name       := attrs.name,
                          Nodes      := rec(),
                          Edges      := [],
                          Subgraphs  := [],
                          GraphAttrs := [],
                          NodeAttrs  := [],
                          EdgeAttrs  := [],
                          Comments   := [],
                          Lines      := []));

  if IsBound(attrs.comment) then
    GV_Comment(result, attrs.comment);
  fi;
  Add(GV_Lines(result), ["Head"]);
  return result;
end);

InstallMethod(GV_Graph, "for a string", [IsString],
function(name)
  return GV_Graph(rec(name := name));
end);


InstallMethod(GV_Graph, "for no args", [], {} -> GV_Graph(rec()));

InstallMethod(GV_Digraph, "for a string", [IsRecord],
function(attrs)
  local result;

  if not IsBound(attrs.name) then
    attrs.name := "";
  fi;

  # TODO other attrs
  result := Objectify(GV_DigraphType,
                      rec(HeadFunc   := GV_StringifyDigraphHead,
                          EdgeFunc   := GV_StringifyDigraphEdge,
                          Name       := attrs.name,
                          Nodes      := rec(),
                          Edges      := [],
                          Subgraphs  := [],
                          GraphAttrs := [],
                          NodeAttrs  := [],
                          EdgeAttrs  := [],
                          Comments   := [],
                          Lines      := []));

  if IsBound(attrs.comment) then
    GV_Comment(result, attrs.comment);
  fi;
  Add(GV_Lines(result), ["Head"]);
  return result;
end);

InstallMethod(GV_Digraph, "for a string", [IsString],
function(name)
  return GV_Digraph(rec(name := name));
end);

InstallMethod(GV_Digraph, "for no args", [], {} -> GV_Digraph(rec()));

###############################################################################
# Printing and viewing
###############################################################################

InstallMethod(ViewString, "for a GV graph",
[IsGVGraph],
function(gvg)
  return StringFormatted("<graphviz graph object with {} nodes and {} edges>",
                         Length(NamesOfComponents(GV_Nodes(gvg))),
                         Length(GV_Edges(gvg)));
end);

InstallMethod(ViewString, "for a GV digraph",
[IsGVDigraph],
function(x)
  return StringFormatted("<graphviz digraph object with {} nodes and {} edges>",
                         Length(NamesOfComponents(GV_Nodes(x))),
                         Length(GV_Edges(x)));
end);

###############################################################################
# Getters
###############################################################################

InstallMethod(GV_Name, "for a graphviz object", [IsGVObject], x -> x!.Name);

InstallMethod(GV_GraphAttrs, "for a graphviz object", [IsGVObject],
x -> x!.GraphAttrs);

InstallMethod(GV_NodeAttrs, "for a graphviz object", [IsGVObject],
x -> x!.NodeAttrs);

InstallMethod(GV_EdgeAttrs, "for a graphviz object", [IsGVObject],
x -> x!.EdgeAttrs);

InstallMethod(GV_Nodes, "for a graphviz object", [IsGVObject],
x -> x!.Nodes);

InstallMethod(GV_Edges, "for a graphviz object", [IsGVObject],
x -> x!.Edges);

InstallMethod(GV_Comments, "for a graphviz object", [IsGVObject],
x -> x!.Comments);

InstallMethod(GV_Lines, "for a graphviz object", [IsGVObject],
x -> x!.Lines);

InstallMethod(GV_Subgraphs, "for a graphviz object", [IsGVObject],
x -> x!.Subgraphs);

###############################################################################
# Setters
###############################################################################

InstallMethod(GV_Name, "for a graphviz object and string",
[IsGVObject, IsString],
function(x, name)
  x!.Name := name;
  return x;
end);

InstallMethod(GV_GraphAttr, "for a graphviz object, record, and pos int",
[IsGVObject, IsRecord, IsPosInt],
function(x, attr, line_number)
  # TODO Check that line_number is after Head position in Lines
  Add(GV_GraphAttrs(x), attr);
  InsertElmList(GV_Lines(x),
                line_number,
                ["GraphAttr", Length(GV_GraphAttrs(x))]);
  x!.Lines := Compacted(x!.Lines);
  return x;
end);

InstallMethod(GV_GraphAttr, "for a graphviz object and record",
[IsGVObject, IsRecord],
function(x, attr)
  return GV_GraphAttr(x, attr, Length(GV_Lines(x)) + 1);
end);

InstallMethod(GV_NodeAttr, "for a graphviz object, record, and pos int",
[IsGVObject, IsRecord, IsPosInt],
function(x, attr, line_number)
  Add(GV_NodeAttrs(x), attr);
  InsertElmList(GV_Lines(x), line_number, ["NodeAttr", Length(GV_NodeAttrs(x))]);
  x!.Lines := Compacted(x!.Lines);
  return x;
end);

InstallMethod(GV_NodeAttr, "for a graphviz object and record",
[IsGVObject, IsRecord],
function(x, attr)
  return GV_NodeAttr(x, attr, Length(GV_Lines(x)) + 1);
end);

InstallMethod(GV_EdgeAttr, "for a graphviz object, record, and pos int",
[IsGVObject, IsRecord, IsPosInt],
function(x, attr, line_number)
  Add(GV_EdgeAttrs(x), attr);
  InsertElmList(GV_Lines(x), line_number, ["EdgeAttr", Length(GV_EdgeAttrs(x))]);
  return x;
end);

InstallMethod(GV_EdgeAttr, "for a graphviz object and record",
[IsGVObject, IsRecord],
function(x, attr)
  return GV_EdgeAttr(x, attr, Length(GV_Lines(x)) + 1);
end);

InstallMethod(GV_Node, "for a graphviz object, string, record, pos. int.",
[IsGVObject, IsString, IsRecord, IsPosInt],
function(x, name, attrs, line_number)
  local nodes, lines;
  nodes := GV_Nodes(x);
  lines := GV_Lines(x);

  # remove old node if it exists
  if IsBound(nodes.(name)) then
    lines := Filtered(lines, info -> not (info[1] = "Node" and info[2] = name)); 
  fi;
  
  nodes.(name) := attrs;
  InsertElmList(lines, line_number, ["Node", name]);
  x!.Lines := Compacted(lines);
  return x;
end);

InstallMethod(GV_Node, "for a graphviz object, string, and record",
[IsGVObject, IsString, IsRecord],
function(x, name, attrs)
  return GV_Node(x, name, attrs, Length(GV_Lines(x)) + 1);
end);

InstallMethod(GV_Node, "for a graphviz object, string, string",
[IsGVObject, IsString, IsString, IsRecord],
function(x, name, label, attrs)
  attrs.label := label;
  return GV_Node(x, name, attrs);
end);

InstallMethod(GV_Node, "for a graphviz object, string, string",
[IsGVObject, IsString, IsString, IsRecord],
function(x, name, label, attrs)
  attrs.label := label;
  return GV_Node(x, name, attrs);
end);

InstallMethod(GV_Node, "for a graphviz object, string, string",
[IsGVObject, IsString, IsString],
function(x, name, label)
  return GV_Node(x, name, rec(label := label));
end);

InstallMethod(GV_Node, "for a graphviz object, string, pos-int",
[IsGVObject, IsString, IsPosInt],
function(x, name, line)
  return GV_Node(x, name, rec(), line);
end);

InstallMethod(GV_Node, "for a graphviz object and string",
[IsGVObject, IsString],
function(x, name)
  return GV_Node(x, name, rec());
end);

InstallMethod(GV_Edge,
"for a graphviz object, string, string, record and posivite integer",
[IsGVObject, IsString, IsString, IsRecord, IsPosInt],
function(x, tail_name, head_name, attrs, line)
  Add(GV_Edges(x), [tail_name, head_name, attrs]);
  InsertElmList(GV_Lines(x), line, ["Edge", Length(GV_Edges(x))]);
  return x;
end);

InstallMethod(GV_Edge,
"for a graphviz object, string, string, record",
[IsGVObject, IsString, IsString, IsRecord],
function(x, tail_name, head_name, attrs)
  Add(GV_Edges(x), [tail_name, head_name, attrs]);
  Add(GV_Lines(x), ["Edge", Length(GV_Edges(x))]);
  return x;
end);

InstallMethod(GV_Edge,
"for a graphviz object, string, string, record",
[IsGVObject, IsString, IsString, IsPosInt],
function(x, tail_name, head_name, line)
  return GV_Edge(x, tail_name, head_name, rec(), line);
end);

InstallMethod(GV_Edge, "for a graphviz object, string, string",
[IsGVObject, IsString, IsString],
function(x, tail_name, head_name)
  return GV_Edge(x, tail_name, head_name, rec());
end);

InstallMethod(GV_Comment, "for a graphviz object, string, and pos int",
[IsGVObject, IsString, IsPosInt],
function(x, comment, line_number)
  Add(GV_Comments(x), comment);
  InsertElmList(GV_Lines(x), line_number, ["Comment", Length(GV_Comments(x))]);
  return x;
end);

InstallMethod(GV_Comment, "for a graphviz object and string",
[IsGVObject, IsString],
function(x, comment)
  return GV_Comment(x, comment, Length(GV_Lines(x)) + 1);
end);

InstallMethod(GV_BeginSubgraph, 
"for a graphviz object, string and pos int",
[IsGVObject, IsString, IsPosInt],
function(x, name, line_number) 
  Add(GV_Subgraphs(x), name);
  InsertElmList(GV_Lines(x), line_number, ["SubBegin", Length(GV_Subgraphs(x))]);
  return x;
end);

InstallMethod(GV_BeginSubgraph, 
"for a graphviz object and a string",
[IsGVObject, IsString],
function(x, name) 
  return GV_BeginSubgraph(x, name, Length(GV_Lines(x)) + 1);
end);

InstallMethod(GV_BeginSubgraph, 
"for a graphviz object and a pos int",
[IsGVObject, IsPosInt],
function(x, line_number) 
  return GV_BeginSubgraph(x, "", line_number);
end);

InstallMethod(GV_BeginSubgraph, 
"for a graphviz object",
[IsGVObject],
function(x) 
  return GV_BeginSubgraph(x, "");
end);

InstallMethod(GV_EndSubgraph, 
"for a graphviz object and pos int",
[IsGVObject, IsPosInt],
function(x, line_number) 
  InsertElmList(GV_Lines(x), line_number, ["SubEnd"]);
  return x;
end);

InstallMethod(GV_EndSubgraph, 
"for a graphviz object",
[IsGVObject],
function(x) 
  return GV_EndSubgraph(x, Length(GV_Lines(x)) + 1);
end);

DeclareOperation("GV_RemoveNode", [ IsGVObject, IsString ]);
InstallMethod(GV_RemoveNode, 
"for a graphviz object and a string",
[IsGVObject, IsString],
function(x, name)
  Unbind(GV_Nodes(x).(name));
end);

DeclareOperation("GV_RemoveList", [ IsGVObject, IsList, IsString, IsPosInt ]);
InstallMethod(GV_RemoveList, 
"for a graphviz object, list, string and pos int",
[IsGVObject, IsList, IsString, IsPosInt],
function(x, list, type, idx)
  local lines, line;
  lines := GV_Lines(x);

  for line in lines do
    if line[1] = type and line[2] > idx then
      line[2] := line[2] - 1;
    fi;
  od;

  Remove(list, idx);
end);

InstallMethod(GV_Remove, "for a graphviz object and a pos int",
[IsGVObject, IsPosInt],
function(x, line_number)
  local r;
  r := Remove(GV_Lines(x), line_number);
  x!.Lines := Compacted(GV_Lines(x));

  if r[1] = "Node" then
    GV_RemoveNode(x, r[2]);
  elif r[1] = "Edge" then
    GV_RemoveList(x, GV_Edges(x), "Edge", r[2]);
  elif r[1] = "GraphAttr" then
    GV_RemoveList(x, GV_GraphAttrs(x), "GraphAttr", r[2]);
  elif r[1] = "NodeAttr" then
    GV_RemoveList(x, GV_NodeAttrs(x), "NodeAttr", r[2]);
  elif r[1] = "EdgeAttr" then
    GV_RemoveList(x, GV_EdgeAttrs(x), "EdgeAttr", r[2]);
  elif r[1] = "SubBegin" then
    GV_RemoveList(x, GV_Subgraphs(x), "SubBegin", r[2]);
  fi;

  return x;
end);

###############################################################################
# Stringifying
###############################################################################

#@ Return comment header line.
InstallMethod(GV_StringifyComment, "for a string", [IsString],
function(line)
  return StringFormatted("//{}\n", line);
end);

#@ Return DOT subgraph start line.
InstallMethod(GV_StringifySubgraphBegin, "for a string", [IsString],
function(name)
  return StringFormatted("\tsubgraph {} {{\n", name);
end);

#@ Return DOT subgraph end line.
InstallMethod(GV_StringifySubgraphEnd, "for a string", [],
function()
  return StringFormatted("\t}}\n");
end);


#@ Return DOT graph head line.
InstallMethod(GV_StringifyGraphHead, "for a string", [IsString],
function(name)
  return StringFormatted("graph {} {{\n", name);
end);

#@ Return DOT digraph head line.
InstallMethod(GV_StringifyDigraphHead, "for a string", [IsString],
function(name)
  return StringFormatted("digraph {} {{\n", name);
end);

#@ Return DOT node statement line.
InstallMethod(GV_StringifyNode, "for string and record",
[IsString, IsRecord],
function(name, attrs)
  return StringFormatted("\t{}{}\n", name, GV_StringifyNodeEdgeAttrs(attrs));
end);

#@ Return DOT graph edge statement line.
InstallMethod(GV_StringifyGraphEdge, "for string, string, record",
[IsString, IsString, IsRecord],
function(tail, head, attrs)
  return StringFormatted("\t{} -- {}{}\n",
                         tail,
                         head,
                         GV_StringifyNodeEdgeAttrs(attrs));

end);

#@ Return DOT digraph edge statement line.
InstallMethod(GV_StringifyDigraphEdge, "for string, string, record",
[IsString, IsString, IsRecord],
function(tail, head, attrs)
  return StringFormatted("\t{} -> {}{}\n",
                         tail,
                         head,
                         GV_StringifyNodeEdgeAttrs(attrs));

end);

#@ Return DOT subgraph head line.
InstallMethod(GV_StringifySubgraph, "for a string",
[IsString],
function(name)
  return StringFormatted("subgraph {}{{\n", name);
end);

#@ Return plain DOT subgraph head line.
InstallMethod(GV_StringifyPlainSubgraph, "for a string",
[IsString],
function(name)
  return StringFormatted("{}{{\n", name);
end);

InstallMethod(GV_StringifyGraphAttrs, "for a record", [IsRecord],
function(attrs)
  local result, attr_names, n, i;
  result := "";
  attr_names := NamesOfComponents(attrs);
  n := Length(attr_names);
  if n <> 0 then
    Append(result, "\t");
    for i in [1 .. n] do
      Append(result,
             StringFormatted("{}=\"{}\" ",
                             attr_names[i],
                             attrs.(attr_names[i])));
    od;
    Append(result, "\n");
  fi;
  return result;
end);

InstallMethod(GV_StringifyNodeEdgeAttrs, "for a record", [IsRecord],
function(attrs)
  local result, attr_names, n, i;

  result := "";
  attr_names := NamesOfComponents(attrs);
  n := Length(attr_names);
  if n <> 0 then
    Append(result, " [");
    for i in [1 .. n - 1] do
      if attr_names[i] = "label" then
        Append(result,
               StringFormatted("{}=\"{}\", ",
                               attr_names[i],
                               attrs.(attr_names[i])));
      else
        Append(result,
               StringFormatted("{}={}, ",
                               attr_names[i],
                               attrs.(attr_names[i])));
      fi;
    od;
    if attr_names[n] = "label" then
      Append(result,
             StringFormatted("{}=\"{}\"]",
                             attr_names[n],
                             attrs.(attr_names[n])));
    else
      Append(result,
             StringFormatted("{}={}]",
                             attr_names[n],
                             attrs.(attr_names[n])));
    fi;
  fi;
  return result;
end);

DeclareOperation("GV_ValidateSubgraphs", [IsGVObject]);
InstallMethod(GV_ValidateSubgraphs, "validate graphviz subgraphs",
[IsGVObject],
function(x)
  local depth, lineIdx, line, lines;

  lineIdx := 0;
  depth := 0;
  lines := GV_Lines(x);
  for lineIdx in [1..Length(lines)] do
    line := lines[lineIdx];

    if line[1] = "SubBegin" then
      depth := depth + 1;
    elif line[1] = "SubEnd" then
      depth := depth - 1;
    fi;

    if depth < 0 then
      return [depth, lineIdx];
    fi;
  od;

  return [depth, lineIdx];
end);

InstallMethod(GV_String, "for a graphviz object",
[IsGVObject],
function(x)
  local result, info, line, i;

  info := GV_ValidateSubgraphs(x);
  if info[1] < 0 then
    return StringFormatted("Failed to output - Too many ending brackets. Line: {}\n", info[2]);
  elif info[1] > 0 then 
    return "Failed to output - Too few ending brackets\n";
  fi;

  result := "";
  for i in [1 .. Length(GV_Lines(x))] do
    line := GV_Lines(x)[i];
    if line[1] = "Head" then
      Append(result, GV_Head(x));
    elif line[1] = "Node" then
      Append(result,
             CallFuncList(GV_StringifyNode, [line[2], GV_Nodes(x).(line[2])]));
    elif line[1] = "Edge" then
      Append(result, CallFuncList(x!.EdgeFunc, GV_Edges(x)[line[2]]));
    elif line[1] = "GraphAttr" then
      Append(result, GV_StringifyGraphAttrs(GV_GraphAttrs(x)[line[2]]));
    elif line[1] = "NodeAttr" then
      Append(result,
             StringFormatted("\tnode {}\n",
                             GV_StringifyNodeEdgeAttrs(GV_NodeAttrs(x)[line[2]])));
    elif line[1] = "EdgeAttr" then
      Append(result,
             StringFormatted("\tedge {}\n",
                             GV_StringifyNodeEdgeAttrs(GV_EdgeAttrs(x)[line[2]])));
    elif line[1] = "Comment" then
      Append(result, GV_StringifyComment(GV_Comments(x)[line[2]]));
    elif line[1] = "SubBegin" then
      Append(result, GV_StringifySubgraphBegin(GV_Subgraphs(x)[line[2]]));
    elif line[1] = "SubEnd" then
      Append(result, GV_StringifySubgraphEnd());
    fi;
  od;
  Append(result, "}\n");
  return result;
end);


InstallMethod(GV_Peek, "for a graphviz object",
[IsGVObject],
function(x)
  local result, info, line, i;

  info := GV_ValidateSubgraphs(x);
  if info[1] < 0 then
    return StringFormatted("Failed to output - Too many ending brackets. Line: {}\n", info[2]);
  elif info[1] > 0 then 
    return "Failed to output - Too few ending brackets\n";
  fi;


  result := "";
  for i in [1 .. Length(GV_Lines(x))] do
    line := GV_Lines(x)[i];
    if line[1] = "Head" then
      Append(result, 
          StringFormatted("{} {}", i, GV_Head(x)));
    elif line[1] = "Node" then
      Append(result,
          StringFormatted("{} {}", i, CallFuncList(GV_StringifyNode, [line[2], GV_Nodes(x).(line[2])])));
    elif line[1] = "Edge" then
      Append(result, 
          StringFormatted("{} {}", i, CallFuncList(x!.EdgeFunc, GV_Edges(x)[line[2]])));
    elif line[1] = "GraphAttr" then
      Append(result, GV_StringifyGraphAttrs(GV_GraphAttrs(x)[line[2]]));
    elif line[1] = "NodeAttr" then
      Append(result,
             StringFormatted("{} \tnode {}\n",
                             i, GV_StringifyNodeEdgeAttrs(GV_NodeAttrs(x)[line[2]])));
    elif line[1] = "EdgeAttr" then
      Append(result,
             StringFormatted("{} \tedge {}\n",
                             i, GV_StringifyNodeEdgeAttrs(GV_EdgeAttrs(x)[line[2]])));
    elif line[1] = "Comment" then
      Append(result, 
              StringFormatted("{} {}", i, GV_StringifyComment(GV_Comments(x)[line[2]])));
    elif line[1] = "SubBegin" then
      Append(result, 
        StringFormatted("{} {}", i, GV_StringifySubgraphBegin(GV_Subgraphs(x)[line[2]])));
    elif line[1] = "SubEnd" then
      Append(result, 
        StringFormatted("{} {}", i, GV_StringifySubgraphEnd()));
    fi;
  od;
  Append(result, "}\n");
  return result;
end);

InstallMethod(GV_Save, 
"for graphviz object and string",
[IsGVObject, IsString],
function(x, path)
  PrintTo(path, GV_String(x));
end);

InstallMethod(GV_DotDigraph,
"for a digraph",
[IsDigraph, IsList, IsList],
function(D, node_funcs, edge_funcs)
  local x, func, str, out, i, j, l;
  
  x := GV_Digraph();
  GV_Comment(x, "dot", 1);
  GV_NodeAttr(x, rec( shape := "circle" ));

  for i in DigraphVertices(D) do
    GV_Node(x, StringFormatted("{}", i));
    for func in node_funcs do 
      func(x, i);
    od;
  od;

  out := OutNeighbours(D);
  for i in DigraphVertices(D) do
    l := Length(out[i]);
    for j in [1 .. l] do
      GV_Edge(x, StringFormatted("{}", i), StringFormatted("{}", out[i][j]));
      for func in edge_funcs do 
        func(x, i, j);
      od;
    od;
  od;
  return x;
end);


BindGlobal("GV_DIGRAPHS_ValidRGBValue",
function(str)
  local l, chars, x, i;
  l := Length(str);
  x := 0;
  chars := "0123456789ABCDEFabcdef";
  if l = 7 then
    if str[1] = '#' then
      for i in [2 .. l] do
        if str[i] in chars then
            x := x + 1;
        fi;
      od;
    fi;
  fi;
  if x = (l - 1) then
    return true;
  else
    return false;
  fi;
end);

BindGlobal("GV_DIGRAPHS_GraphvizColorsList", fail);

BindGlobal("GV_DIGRAPHS_GraphvizColors",
function()
  local f;
  if GV_DIGRAPHS_GraphvizColorsList = fail then
    f := IO_File(Concatenation(DIGRAPHS_Dir(), "/data/colors.p"));
    MakeReadWriteGlobal("GV_DIGRAPHS_GraphvizColorsList");
    GV_DIGRAPHS_GraphvizColorsList := IO_Unpickle(f);
    MakeReadOnlyGlobal("GV_DIGRAPHS_GraphvizColorsList");
    IO_Close(f);
  fi;
  return GV_DIGRAPHS_GraphvizColorsList;
end);

BindGlobal("GV_DIGRAPHS_ValidVertColors",
function(D, verts)
  local v, sum, colors, col;
  v := DigraphVertices(D);
  sum := 0;
  if Length(verts) <> Length(v) then
    ErrorNoReturn("the number of vertex colors must be the same as the number",
    " of vertices, expected ", Length(v), " but found ", Length(verts), "");
  fi;
  colors := GV_DIGRAPHS_GraphvizColors();
  if Length(verts) = Length(v) then
    for col in verts do
      if not IsString(col) then
        ErrorNoReturn("expected a string");
      elif GV_DIGRAPHS_ValidRGBValue(col) = false and
          (col in colors) = false then
        ErrorNoReturn("expected RGB Value or valid color name as defined",
        " by GraphViz 2.44.1 X11 Color Scheme",
        " http://graphviz.org/doc/info/colors.html");
      else
        sum := sum + 1;
      fi;
    od;
    if sum = Length(verts) then
      return true;
    fi;
  fi;
end);

BindGlobal("GV_DIGRAPHS_ValidEdgeColors",
function(D, edge)
  local out, l, counter, sum, colors, v, col;
  out := OutNeighbours(D);
  l := Length(edge);
  counter := 0;
  sum := 0;
  colors := GV_DIGRAPHS_GraphvizColors();
  if Length(edge) <> Length(out) then
    ErrorNoReturn("the list of edge colors needs to have the",
    " same shape as the out-neighbours of the digraph");
  else
    for v in [1 .. l] do
      sum := 0;
      if Length(out[v]) <> Length(edge[v]) then
        ErrorNoReturn("the list of edge colors needs to have the",
        " same shape as the out-neighbours of the digraph");
      else
        for col in edge[v] do
          if not IsString(col) then
            ErrorNoReturn("expected a string");
          elif GV_DIGRAPHS_ValidRGBValue(col) = false and
              (col in colors) = false then
            ErrorNoReturn("expected RGB Value or valid color name as defined",
            " by GraphViz 2.44.1 X11 Color Scheme",
            " http://graphviz.org/doc/info/colors.html");
          else
            sum := sum + 1;
          fi;
        od;
        if sum = Length(edge[v]) then
          counter := counter + 1;
        fi;
      fi;
    od;
    if counter = Length(edge) then
      return true;
    fi;
  fi;
end);

InstallMethod(GV_DotDigraph, 
"for a digraph by out-neighbours",
[IsDigraphByOutNeighboursRep],
D -> GV_DotDigraph(D, [], []));

InstallMethod(GV_DotColoredDigraph, 
"for a digraph by out-neighbours and two lists",
[IsDigraphByOutNeighboursRep, IsList, IsList],
function(D, vert, edge)
  local vert_func, edge_func;
  if GV_DIGRAPHS_ValidVertColors(D, vert) and GV_DIGRAPHS_ValidEdgeColors(D, edge) then
    vert_func := function(x, i)
      local l;
      l := StringFormatted("{}", i);
      GV_Node(x, l, rec(style:="filled", color:=vert[i]));
    end;
    edge_func := function(x, i, j)
      local l1, l2;
      l1 := StringFormatted("{}", i);
      l2 := StringFormatted("{}", j);
      GV_Remove(x, Length(GV_Lines(x)));
      GV_Edge(x, l1, l2, rec(color:=edge[i][j]));
    end;
    return GV_DotDigraph(D, [vert_func], [edge_func]);
  fi;
end);

InstallMethod(DotEdgeColoredDigraph,
"for a digraph by out-neighbours and a list",
[IsDigraphByOutNeighboursRep, IsList],
function(D, edge)
  local func;
  if DIGRAPHS_ValidEdgeColors(D, edge) then
    func := function(x, i, j)
      local l1, l2;
      l1 := StringFormatted("{}", i);
      l2 := StringFormatted("{}", j);
      GV_Remove(x, Length(GV_Lines(x)));
      GV_Edge(x, l1, l2, rec(color:=edge[i][j]));
    end;
    return GV_DotDigraph(D, [], [func]);
  fi;
end);

InstallMethod(DotVertexLabelledDigraph, "for a digraph by out-neighbours",
[IsDigraphByOutNeighboursRep],
function(D)
  local func;
  func := function(x, i)
    local l;
    l := StringFormatted("{}", i);
    GV_Node(x, l, rec(label:=DigraphVertexLabel(D, i)));
  end;  
  return GV_DotDigraph(D, [func], []);
end);
