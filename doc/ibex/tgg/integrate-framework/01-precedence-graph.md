# Precedence Graph

A precedence graph is a directed acyclic graph which (in its basic form) describes applied rules and their dependencies. A node represents a rule application. An edge between two nodes represents the dependency of a rule application from another rule application. When, additionally, model changes are considered, the nodes of a precedence graph can be annotated with information that help to identify e.g. repairable spots in the model or change conflicted areas. For more scientific information about precedence graphs consider to read the following paper: [TODO].

## Implementation

The `PrecedenceGraph` of the INTEGRATE framework is implemented as a set of nodes which themselves contain references to their depending nodes (`requires`) and vice versa (`requiredBy`). Each node is tightly coupled with its respective `TGGMatch` and has an indicator (`broken`) if the rule application it represents has become invalid. The `PrecedenceGraph`, additionally, holds several caching sets and maps to boost performance. 

### Construction

The `PrecedenceGraph` is constructed dynamically at runtime and immediately reflects changes to the set of matching patterns. To achieve this, the `PrecedenceGraph` registers itself with the `MatchDistributor` (which is connected to the pattern matcher) to get notified if matches change.
