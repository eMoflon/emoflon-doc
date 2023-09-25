# Match Classifier

The `MatchClassifier` provides different information about model changes related to specific rule applications (which are usually addressed by their respective *consistency* matches) at a specific point of time. A classified match comprises the following information:

* The status of a match (intact, broken, or implicitly broken)
* The deletion pattern, which describes the grade of deletion (completely, partly, or unchanged) according to the domain and binding type
* The deletion type, which classifies the match into one of several predefined types based on its deletion pattern
* Filter NAC violations, which indicate that forbidden context appeared in whose presence a rule would not be applicable
* Constrained attribute changes, which are attribute changes that violate an attribute condition
* In-place attribute changes, which are attribute changes that violate an attribute assignment

## Implementation

The `MatchClassifier` consists of a `TGGMatch` to `ClassifiedMatch` mapping. Classified matches are stored until one of the `clear*`-methods gets invoked. Therefore, its up to the user to manage the actuality of the stored entries.

The above mentioned information in a `ClassifiedMatch` need different sources to be determined. The match status is obtained from the `PrecedenceGraph`. For all other information the `MatchUtil` is utilized, which is described [here](07-match-util.md) in its detail.
