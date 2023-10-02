# Conflict Resolver

Detected conflicts can be resolved by pre-defined strategies. For each conflict type is defined which strategies can be applied. The user can then decide for each conflict which strategy to take. The following strategies are available (for more see [Fritsche, et al. (2020), Chapter 5](https://doi.org/10.1145/3426425.3426931)):

* **Take Source:** Discards all changes in the target domain
* **Take Target:** Discards all changes in the source domain
* **Preserve:** Discards all deletions that block newly added elements from being propagated

## API

The user's conflict resolution logic can be plugged in by implementing the `ConflictResolver`-interface and passing an instance into the `IbexOptions`. The `ConflictResolver`-interface requires a `resolveConflict()`-method, which should resolve all conflicts of a `ConflictContainer` and its sub-containers. A conflict resolution strategy can be applied to a conflict be calling a respective method of a `Conflict`-object beginning with `crs_`.

The `CRSHelper`-class provides additional methods for a simplified conflict resolution:
* The `forEachConflict()`-method executes a given action for every conflict of a `ConflictContainer` and its sub-containers.
* The `forEachResolve()`-method resolves only conflicts of the given type of a `ConflictContainer` and its sub-containers with the given strategy. Conflicts of other types remain unresolved.

### Integrate Language

As part of the INTEGRATE framework, we provide a DSL for specifying evaluation functions. Within the DSL one is able to use information about the elements of a conflict scope to define a function which decides if a certain conflict resolution strategy will be applied or not. More information about the Integrate Language can be found here: TODO

## Implementation

Every conflict resolution strategy is an interface which needs to be implemented by a conflict type to be applicable. In addition to the strategies mentioned above, the implementation comprises several more strategies:

* Available for: **All conflict types except inconsistent domain changes conflicts**

  * **Prefer Source:** Discards all changes in the target domain (equivalent to *Take Source*).

  * **Prefer Target:** Discards all changes in the source domain (equivalent to *Take Target*).

* Available for: **Preserve-delete conflicts**

  * **Merge And Preserve:** Discards all deletions that block newly added elements from being propagated (equivalent to *Preserve*).

  * **Revoke Addition:** Discards all changes in the domain that has the conflicting, newly added elements. Effectively executes *Prefer Source* or *Prefer Target* depending on which domain needs to be discarded.

  * **Revoke Deletion:** Discards all changes in the domain that has the conflicting deletions. Effectively executes *Prefer Source* or *Prefer Target* depending on which domain needs to be discarded.

* Available for: **Correspondence preservation & inconsistent domain changes conflicts**

  * **Delete Correspondences:** Deletes all elements in the correspondence domain, thus, all conflicted elements may be propagated separately later.

  * **Act And Let Repair:** Executes a given delta specified by the user and, then, initiates a repair process. Gives the user wide control on how to modify the model to resolve the conflict. There is no guaranty the conflict is resolved afterwards.

* Available for: **Inconsistent domain changes conflicts**

  * **Revoke Changes:** Discards all changes in the domain which has inconsistent changes.

### Helper methods for conflict resolution

Every conflict type individually implements its resolution strategies. For that, the `Conflict`-class provides several helper methods:

* The `restoreMatch()`-method restores a broken rule application based on its former found *consistency* match. This method only restores deleted elements. Attribute changes are not addressed.

* The `restoreDomain()`-method is similar to the `restoreMatch()`-method but only restores the elements of the specified domain.

* The `revokeMatch()`-method deletes all created elements of the respective rule application for the given match. For *source*/*target* and *forward*/*backward* matches, this means, that only the matched elements (i.e. the elements of the *source* or *target* domain, depending on the match) are deleted.

* The `revertRepairable()`-method ...
