# INTEGRATE Framework: Overview

INTEGRATE is a collection of tools that provide functionalities needed for various advanced eMoflon::IBeX features like concurrent synchronization, and higher-order repair. It comprises the following tools:

* [Precedence Graph](precedence-graph.md)
* [Match Classifier](match-classifier.md)
* [Multiplicity Counter](multiplicity-counter.md)
* [Conflict Detector](conflict-detector.md)
* [Conflict Resolver](conflict-resolver.md)
* [Revoker](revoker.md)

As well as the following notable helper tools:

* [Match Util](match-util.md)
* [Match Analyzer](match-analyzer.md)
* [Model Change Protocol](model-change-protocol.md)

Together with the *sequential synchronization framework* and *local consistency check framework*, all these tools are utilized by INTEGRATE to form a synchronization tool kit. Fragments are used to compose a custom synchronization flow. INTEGRATE provides a set of predefined Fragments:

* [Fragment Provider](fragment-provider.md)
