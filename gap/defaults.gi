#############################################################################
##
##  display.gi
##  Copyright (C) 2014-21                                James D. Mitchell
##
##  Licensing information can be found in the README file of this package.
##
#############################################################################
##
# AN's code, adapted by WW

BindGlobal("GV_DIGRAPHS_DotDigraph",
function(D, node_funcs, edge_funcs)
  local out, nodes, tail, head, node, edge, graph, i, func, j, l;

  graph := GV_Graph("hgn");
  GV_Type(graph, GV_DIGRAPH);
  GV_NodeAttrs(graph, rec( shape := "circle"));

  for i in DigraphVertices(D) do
    node := GV_Node(StringFormatted("{}", i));
    GV_AddNode(graph, node);
    for func in node_funcs do
      func(graph, node, i);
    od;
  od;

  nodes := GV_Nodes(graph);
  out := OutNeighbours(D);
  for i in DigraphVertices(D) do
    l := Length(out[i]);
    for j in [1 .. l] do
      tail := nodes.(StringFormatted("{}", i));
      head := nodes.(StringFormatted("{}", out[i][j]));
      edge := GV_Edge(head, tail);
      GV_AddEdge(graph, edge);
      for func in edge_funcs do
        func(graph, edge, i, j);
      od;
    od;
  od;
  return graph;
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

InstallMethod(GV_DotDigraph, "for a digraph by out-neighbours",
[IsDigraphByOutNeighboursRep],
D -> GV_DIGRAPHS_DotDigraph(D, [], []));

InstallMethod(GV_DotColoredDigraph, "for a digraph by out-neighbours and two lists",
[IsDigraphByOutNeighboursRep, IsList, IsList],
function(D, vert, edge)
  local vert_func, edge_func;
  if DIGRAPHS_ValidVertColors(D, vert) and DIGRAPHS_ValidEdgeColors(D, edge) then
    vert_func := {g, n, i} -> GV_Attrs(n, rec(color := vert[i], style := "filled"));
    edge_func := {g, e, i, j} -> GV_Attrs(e, rec(color := edge[i][j]));
    return DIGRAPHS_DotDigraph(D, [vert_func], [edge_func]);
  fi;
end);

InstallMethod(GV_DotVertexColoredDigraph,
"for a digraph by out-neighbours and a list",
[IsDigraphByOutNeighboursRep, IsList],
function(D, vert)
  local func;
  if DIGRAPHS_ValidVertColors(D, vert) then
    func := {g, n, i} -> GV_Attrs(n, rec(color := vert[i], style := "filled"));
    return DIGRAPHS_DotDigraph(D, [func], []);
  fi;
end);

InstallMethod(GV_DotEdgeColoredDigraph,
"for a digraph by out-neighbours and a list",
[IsDigraphByOutNeighboursRep, IsList],
function(D, edge)
  local func;
  if DIGRAPHS_ValidEdgeColors(D, edge) then
    func := {g, e, i, j} -> GV_Attrs(e, rec(color := edge[i][j]));
    return DIGRAPHS_DotDigraph(D, [], [func]);
  fi;
end);

InstallMethod(GV_DotVertexLabelledDigraph, "for a digraph by out-neighbours",
[IsDigraphByOutNeighboursRep],
function(D)
  local func;
  func := {g, n, i} -> GV_Attrs(n, rec(label := DigraphVertexLabel(D, i)));
  return DIGRAPHS_DotDigraph(D, [func], []);
end);

BindGlobal("GV_DIGRAPHS_DotSymmetricDigraph",
function(D, node_funcs, edge_funcs)
  local graph, node, nodes, edge, out, n1, n2, str, i, j, func;
  if not IsSymmetricDigraph(D) then
    ErrorNoReturn("the argument <D> must be a symmetric digraph,");
  fi;

  out := OutNeighbours(D);
  
  graph := GV_Graph("hgn");
  GV_NodeAttrs(graph, rec(shape := "circle"));
  for i in DigraphVertices(D) do
    node := GV_Node(StringFormatted("{}", i));
    GV_AddNode(graph, node);
    for func in node_funcs do
      func(graph, node, i);
    od;
  od;

  nodes := GV_Nodes(graph);
  for i in DigraphVertices(D) do
    for j in [1 .. Length(out[i])] do
      if out[i][j] >= i then
        n1 := nodes.(StringFormatted("{}", i));
        n2 := nodes.(StringFormatted("{}", out[i][j]));
        edge := GV_Edge(n1, n2);
        GV_AddEdge(edge);
        for func in edge_funcs do
          func(graph, edge, i, j);
        od;
      fi;
    od;
  od;
  return str;
end);

InstallMethod(DotSymmetricDigraph, "for a digraph by out-neighbours",
[IsDigraphByOutNeighboursRep],
D -> DIGRAPHS_DotSymmetricDigraph(D, [], []));

InstallMethod(DotSymmetricColoredDigraph,
"for a digraph by out-neighbours and two lists",
[IsDigraphByOutNeighboursRep, IsList, IsList],
function(D, vert, edge)
  local vert_func, edge_func;
  if DIGRAPHS_ValidVertColors(D, vert) and DIGRAPHS_ValidEdgeColors(D, edge) then
    vert_func := {g, n, i} -> GV_Attrs(n, rec(color := vert[i], style := "filled"));
    edge_func := {g, e, i, j} -> GV_Attrs(e, rec(color := edge[i][j]));
    return DIGRAPHS_DotSymmetricDigraph(D, [vert_func], [edge_func]);
  fi;
end);

InstallMethod(DotSymmetricVertexColoredDigraph,
"for a digraph by out-neighbours and a list",
[IsDigraphByOutNeighboursRep, IsList],
function(D, vert)
  local func;
  if DIGRAPHS_ValidVertColors(D, vert) then
    func := {g, n, i} -> GV_Attrs(n, rec(color := vert[i], style := "filled"));
    return DIGRAPHS_DotSymmetricDigraph(D, [func], []);
  fi;
end);

InstallMethod(DotSymmetricEdgeColoredDigraph,
"for a digraph by out-neighbours and a list",
[IsDigraphByOutNeighboursRep, IsList],
function(D, edge)
  local func;
  if DIGRAPHS_ValidEdgeColors(D, edge) then
    func := {g, e, i, j} -> GV_Attrs(e, rec(color := edge[i][j]));
    return DIGRAPHS_DotSymmetricDigraph(D, [], [func]);
  fi;
end);

if not IsBound(Splash) then  # This function is written by A. Egri-Nagy
  BindGlobal("VizViewers",
             ["xpdf", "xdg-open", "open", "evince", "okular", "gv"]);

  BindGlobal("Splash",
  function(arg)
    local str, opt, path, dir, tdir, file, viewer, type, inn, filetype, out,
          engine;

    if not IsString(arg[1]) then
      ErrorNoReturn("the 1st argument must be a string,");
    fi;
    str := arg[1];

    opt := rec();
    if IsBound(arg[2]) and IsRecord(arg[2]) then
      opt := arg[2];
    elif IsBound(arg[2]) then
      ErrorNoReturn("the 2nd argument must be a record,");
    fi;

    # path
    path := UserHomeExpand("~/");  # default
    if IsBound(opt.path) then
      path := opt.path;
    fi;

    # directory
    if IsBound(opt.directory) then
      if not opt.directory in DirectoryContents(path) then
        Exec(Concatenation("mkdir ", path, opt.directory));
      fi;
      dir := Concatenation(path, opt.directory, "/");
    elif IsBound(opt.path) then
      if not "tmp.viz" in DirectoryContents(path) then
        tdir := Directory(Concatenation(path, "/", "tmp.viz"));
        dir := Filename(tdir, "");
      fi;
    else
      tdir := DirectoryTemporary();
      dir := Filename(tdir, "");
    fi;

    # file
    file := "vizpicture";  # default
    if IsBound(opt.filename) then
      file := opt.filename;
    fi;

    # viewer
    if IsBound(opt.viewer) then
      viewer := opt.viewer;
      if not IsString(viewer) then
        ErrorNoReturn("the option `viewer` must be a string, not an ",
                      TNAM_OBJ(viewer), ",");
      elif Filename(DirectoriesSystemPrograms(), viewer) = fail then
        ErrorNoReturn("the viewer \"", viewer, "\" specified in the option ",
                      "`viewer` is not available,");
      fi;
    else
      viewer := First(VizViewers, x ->
                      Filename(DirectoriesSystemPrograms(), x) <> fail);
      if viewer = fail then
        ErrorNoReturn("none of the default viewers ", VizViewers,
                      " is available, please specify an available viewer",
                      " in the options record component `viewer`,");
      fi;
    fi;

    # type
    if IsBound(opt.type) and (opt.type = "latex" or opt.type = "dot") then
      type := opt.type;
    elif Length(str) >= 6 and str{[1 .. 6]} = "%latex" then
      type := "latex";
    elif Length(str) >= 5 and str{[1 .. 5]} = "//dot" then
      type := "dot";
    else
      ErrorNoReturn("the component \"type\" of the 2nd argument <a record> ",
                    " must be \"dot\" or \"latex\",");
    fi;
    if type = "latex" then
      inn := Concatenation(dir, file, ".tex");
    else  # type = "dot"
      inn := Concatenation(dir, file, ".dot");
    fi;

    # output type and name
    filetype := "pdf";  # default
    if IsBound(opt.filetype) and IsString(opt.filetype) and type <> "latex" then
      filetype := opt.filetype;
    fi;
    out := Concatenation(dir, file, ".", filetype);

    # engine
    engine := "dot";  # default
    if IsBound(opt.engine) then
      engine := opt.engine;
      if not engine in ["dot", "neato", "twopi", "circo",
                        "fdp", "sfdp", "patchwork"] then
        ErrorNoReturn("the component \"engine\" of the 2nd argument ",
                      "<a record> must be one of: \"dot\", \"neato\", ",
                      "\"twopi\", \"circo\", \"fdp\", \"sfdp\", ",
                      "or \"patchwork\"");
      fi;
    fi;

    # Write and compile the file
    FileString(inn, str);
    if type = "latex" then
      # Requires GAP >= 4.11:
      # Exec(StringFormatted("cd {}; pdflatex {} 2>/dev/null 1>/dev/null", dir);
      Exec(Concatenation("cd ", dir, ";",
                         "pdflatex ", file, " 2>/dev/null 1>/dev/null"));
    else  # type = "dot"
      # Requires GAP >= 4.11:
      # Exec(StringFormatted("{} -T {} {} -o {}", engine, filetype, inn, out));
      Exec(Concatenation(engine, " -T", filetype, " ", inn, " -o ", out));
    fi;
    Exec(Concatenation(viewer, " ", out, " 2>/dev/null 1>/dev/null &"));
  end);
fi;

# CR's code

InstallMethod(DotPartialOrderDigraph, "for a partial order digraph",
[IsDigraph],
function(D)
  if not IsPartialOrderDigraph(D) then
    ErrorNoReturn("the argument <D> must be a partial order digraph,");
  fi;
  D := DigraphMutableCopyIfMutable(D);
  return DotDigraph(DigraphReflexiveTransitiveReduction(D));
end);

InstallMethod(GV_DotPreorderDigraph, "for a preorder digraph",
[IsDigraph],
function(D)
  local comps, quo, red, str, c, x, e, node, graph, label, head, tail, nodes;
  if not IsPreorderDigraph(D) then
    ErrorNoReturn("the argument <D> must be a preorder digraph,");
  fi;

  # Quotient by the strongly connected components to get a partial order
  # D and draw this without loops or edges implied by transitivity.
  D      := DigraphMutableCopyIfMutable(D);
  comps  := DigraphStronglyConnectedComponents(D).comps;
  quo    := DigraphRemoveAllMultipleEdges(QuotientDigraph(D, comps));
  red    := DigraphReflexiveTransitiveReduction(quo);

  graph := GV_Graph("graphname");
  GV_Type(graph, GV_DIGRAPH);
  GV_NodeAttrs(graph, rec(shape := "Mrecord", height := "0.5", fixedsize := "true"));
  GV_Attrs(graph, rec( rankstep := "1"));

  # Each vertex of the quotient D is labelled by its preimage.
  for c in [1 .. Length(comps)] do

    # create node w/ label
    node := GV_Node(String(c));
    label := "\"";
    Append(label, String(comps[c][1]));
    for x in comps[c]{[2 .. Length(comps[c])]} do
      Append(label, "|");
      Append(label, String(x));
    od;
    Append(label, "\"");

    GV_Attrs(node, rec(label := label, width := String(Float(Length(comps[c]) / 2))));
    GV_AddNode(graph, node);
  od;

  # Add the edges of the quotient D.
  nodes := GV_Nodes(graph);
  for e in DigraphEdges(red) do
    tail := nodes.(String(e[1]));
    head := nodes.(String(e[2]));
    GV_AddEdge(graph, GV_Edge(head, tail));
  od;

  return graph;
end);


InstallMethod(GV_DotHighlightedDigraph, "for a digraph and list",
[IsDigraph, IsList],
{D, list} -> GV_DotHighlightedDigraph(D, list, "black", "grey"));

InstallMethod(GV_DotHighlightedDigraph,
"for a digraph by out-neighbours, list, and two strings",
[IsDigraphByOutNeighboursRep, IsList, IsString, IsString],
function(D, highverts, highcolour, lowcolour)
  local lowverts, out, str, i, j;

  if not IsSubset(DigraphVertices(D), highverts) then
    ErrorNoReturn("the 2nd argument <highverts> must be a list of vertices ",
                  "of the 1st argument <D>,");
  elif IsEmpty(highcolour) then
    ErrorNoReturn("the 3rd argument <highcolour> must be a string ",
                  "containing the name of a colour,");
  elif IsEmpty(lowcolour) then
    ErrorNoReturn("the 4th argument <lowcolour> must be a string ",
                  "containing the name of a colour,");
  fi;

  lowverts  := Difference(DigraphVertices(D), highverts);
  out       := OutNeighbours(D);

  graph := GV_Graph("hgn");
  GV_Type(graph, GV_DIGRAPH);

  Append(str, "subgraph lowverts{\n");
  Append(str, Concatenation("node [shape=circle, color=",
                            lowcolour,
                            "]\n edge [color=",
                            lowcolour,
                            "]\n"));

  for i in lowverts do
    Append(str, Concatenation(String(i), "\n"));
  od;

  Append(str, "}\n");

  Append(str, "subgraph highverts{\n");
  Append(str, Concatenation("node [shape=circle, color=",
                            highcolour,
                            "]\n edge [color=",
                            highcolour,
                            "]\n"));

  for i in highverts do
    Append(str, Concatenation(String(i), "\n"));
  od;

  Append(str, "}\n");

  Append(str, "subgraph lowverts{\n");
  for i in lowverts do
    for j in out[i] do
      Append(str, Concatenation(String(i), " -> ", String(j), "\n"));
    od;
  od;
  Append(str, "}\n");

  Append(str, "subgraph highverts{\n");
  for i in highverts do
    for j in out[i] do
      Append(str, Concatenation(String(i), " -> ", String(j)));
      if j in lowverts then
        Append(str, Concatenation(" [color=", lowcolour, "]"));
      fi;
      Append(str, "\n");
    od;
  od;
  Append(str, "}\n}\n");

  return str;
end);
