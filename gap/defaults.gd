DeclareAttribute("GV_DotDigraph", IsDigraph);
DeclareOperation("GV_DotColoredDigraph", [IsDigraph, IsList, IsList]);
DeclareOperation("GV_DotVertexColoredDigraph", [IsDigraph, IsList]);
DeclareOperation("GV_DotEdgeColoredDigraph", [IsDigraph, IsList]);
DeclareOperation("GV_DotVertexLabelledDigraph", [IsDigraph]);
DeclareAttribute("GV_DotSymmetricDigraph", IsDigraph);
DeclareOperation("GV_DotSymmetricColoredDigraph", [IsDigraph, IsList, IsList]);
DeclareOperation("GV_DotSymmetricVertexColoredDigraph", [IsDigraph, IsList]);
DeclareOperation("GV_DotSymmetricEdgeColoredDigraph", [IsDigraph, IsList]);
DeclareAttribute("GV_DotPartialOrderDigraph", IsDigraph);
DeclareAttribute("GV_DotPreorderDigraph", IsDigraph);
DeclareSynonym("GV_DotQuasiorderDigraph", DotPreorderDigraph);
DeclareOperation("GV_DotHighlightedDigraph", [IsDigraph, IsList]);
DeclareOperation("GV_DotHighlightedDigraph", [IsDigraph, IsList, IsString, IsString]);
