# Conflict Detector

The `ConflictDetector` detects most types of conflicts which originate from concurrent model modifications. Shortly explained, these are (for more see [Fritsche, et al. (2020), Chapter 4.2](https://doi.org/10.1145/3426425.3426931)):

* **Preserve-delete conflicts:** A situation where one of the model changes deletes a certain element whereas its corresponding element is used in another model change and thus, intended to persist
* **Correspondence preservation conflicts:** A situation where model changes affect corresponding elements on both source and target side
* **Attribute change conflicts:** A situation where attribute values of until now corresponding source and target elements have been changed in such a way that the attribute values on both sides are no longer consistent

## Implementation

From an implementation point of view, conflicts can be further subcategorized based on the approach which is use to detect them:

* ***Source*/*target* match based detection**
  * Preserve-delete edge conflicts

* **Attribute change based detection**
  * Preserve-delete attribute conflicts
  
* **Broken match based detection**
  * Correspondence preservation conflicts
  * Preserve-delete edge conflicts with need of repair
  * Attribute change conflicts

### Conflict container

TODO

### *Source*/*target* match based detection

A preserve-delete conflict where newly added elements are involved typically have the following characteristics: There is a precedence node that belongs to a *source* or *target* match (called *source*/*target* node). This node (transitively) depends on another a precedence node that belongs to a broken *consistency* match (called broken *consistency* node). To find such a potential set-up, we have to traverse the precedence graph (see method `detectDeletePreserveConflicts()` in `ConflictDetector`). This is done by starting from all *source*/*target* nodes that do not have an element overlapping with other *consistency* nodes. With this, we ensure to only consider newly created elements and exclude matches for alternative rule applications.

From there, all precedence nodes are collected that would cause the *source*/*target* node to be rolled back in the future (`directRollBackCauses`). This is done by using the precedence node's `toBeRolledBackBy`-reference for traversing and searching for broken *consistency* nodes. All nodes in the `directRollBackCauses`-collection are potential candidates for a conflict. To validate if there is an actual conflict, these nodes have to be checked for existing domain-specific violations, which are model changes in a specific domain that violate the validity of a rule application. The considered domain has to be the opposite of the *source*/*target* node (e.g. if we have got a *source* node than we are searching for target-domain violations). If a domain-specific violation exists on one of the nodes or any additional depending node, a conflict is reported. 

**Exceptions:**

There is a possibility that the resolution of other conflicts that are located closer to the root of the precedence graph affect a preserve-delete conflict. This is the case when all domain-specific violations of a preserve-delete conflict get restored by the resolution of another conflict. For this reason, while checking for domain-specific violations, there is also determined, if any correspondence preservation conflicts were found at the checked nodes. The resolution of correspondence preservation conflicts would result in a restoration of the domain-specific violations in any case, thus, the preserve-delete conflict can safely be ignored. This is also the reason why the broken match based detection is always executed before the *source*/*target* match based detection.

### Attribute change based detection

The other type of preserve-delete conflict involves an attribute change that is in conflict with a deletion at the other domain (see method `detectDeletePreserveAttrConflicts()` in `ConflictDetector`). Here, the [Model Change Protocol](09-model-change-protocol.md) can be utilized to get all attribute changes, which are used as a starting point for traversing the precedence graph. The nodes that translate the element of every attribute change are obtained via the precedence graph. Similar to the *source*/*target* match based detection, the domain-specific violations can now be checked and in case of existence, a conflict is reported.

### Broken match based detection

To detect conflicts caused by contradictory changes, we start from all broken and implicitly broken *consistency* nodes (see method `detectBrokenMatchBasedConflicts()` in `ConflictDetector`). Attribute change conflicts are detected by obtaining the attribute changes that violate attribute conditions of the rule application associated with the broken *consistency* node, and check if there is more then one affected parameter from different domains. Currently, this detection is limited to only conditions with *equal* operators and not more then two parameters per condition since detection and meaningful resolution of arbitrary attribute conditions would not be feasible.

Correspondence preservation conflicts are detected by, first, analyzing deletion pattern and filter NAC violations of the broken *consistency* node. A correspondence preservation conflict is present if both source and target domain have translated elements that are partly deleted or any filter NAC violations. If this holds for only one domain, there could also be a preserve-delete edge conflict.

Conflicts with partly deleted domains involved indicate the need of repair after conflict resolution. The resolution of correspondence preservation conflicts provides this by default (see [Conflict Resolver](05-conflict-resolver.md)). But this does not hold for preserve-delete conflicts. Here, the rule application (respectively its match) needs to be explicitly specified to be repaired.

This is done, when 
