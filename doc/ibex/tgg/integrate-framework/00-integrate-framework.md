# INTEGRATE Framework: Overview

INTEGRATE is a collection of tools that provide functionalities needed for various advanced eMoflon::IBeX features like concurrent synchronization, and higher-order repair. It comprises the following tools:

* [Precedence Graph](01-precedence-graph.md)
* [Match Classifier](02-match-classifier.md)
* [Multiplicity Counter](03-multiplicity-counter.md)
* [Conflict Detector](04-conflict-detector.md)
* [Conflict Resolver](05-conflict-resolver.md)
* [Revoker](06-revoker.md)

As well as the following notable helper tools:

* [Match Util](07-match-util.md)
* [Match Analyzer](08-match-analyzer.md)
* [Model Change Protocol](09-model-change-protocol.md)

Together with the *sequential synchronization framework* and *local consistency check framework*, all these tools are utilized by INTEGRATE to form a synchronization tool kit. Fragments are used to compose a custom synchronization flow. INTEGRATE provides a set of predefined Fragments:

* [Fragment Provider](10-fragment-provider.md)
