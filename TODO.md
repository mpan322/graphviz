 - save & load (potentially with 6-strings)
 - condense code in displaying defaults using the new graphviz pkg model
    - ex. all the symmetric vs not symmetric methods can be made a single method which chooses automatically relatively easily.
 - Allow photos to be used as nodes & composition of graphviz output photos (later)
 - Make an abstraction - find in subgraph tree - which does a traversal of the tree of subgraphs to find a graph satisfying a predicate.
 - Make custom resolution of edges for FDP (see fdp example from the python package)
 - implement the fdp example from the python package
 - make it so when duplicates are added to global graph attrs the old values are automatically replaced
 - Improve behaviour around ':' syntax - mimic python package

## TODO
 - Update docs
 - Add more unit tests
 - Thoroughly test the ':' syntax more (might have broke when the quotes were changed)
 - PrintObj method is missing for nodes (and probably edges)

## Image Functions
 - `GraphvizAddGraphNode` -> takes 2 graphs and adds the graph to the to the toher, returning the node. The node will be the same name as the graph, if it already exists then it will error.
 - `GraphvizAttachDigraph / Graph` -> attach a new digraph to the node, returning the digraph / graph

## Other
 - relates to deadnaut github issue https://www.mankier.com/1/nauty-dretodot
 - https://users.cecs.anu.edu.au/~bdm/nauty/nug26.pdf
