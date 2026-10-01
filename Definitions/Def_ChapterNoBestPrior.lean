import Mathlib


/-!
# No prior is uniformly better for every decision problem

The Bayesian-inference chapters of `book.tex` (around lines 1710 and 9125)
state that there is no prior which is better in every case.  This file records
a precise finite no-free-lunch theorem.  A prior is represented by its weights
on a finite hypothesis space, and a "case" by an arbitrary real-valued utility.
If the expected utility under `p` is at least that under `q` for every utility,
then `p = q`.  Thus two genuinely different priors are each preferred by some
utility; neither uniformly dominates the other.
-/

open scoped BigOperators

namespace BookProof.ChapterNoBestPrior

variable {Hyp : Type*} [Fintype Hyp]

/-- Expected utility for a finite weight function. -/
def expectedUtility (p u : Hyp → ℝ) : ℝ := ∑ x, p x * u x

/-
Pointwise recovery from all expected-utility comparisons: if `p` weakly
outperforms `q` for every utility, then their weights coincide.
-/


/-
No two distinct finite priors are ordered by every expected-utility test.
-/


/-
Symmetric no-free-lunch form: for distinct priors there is a utility that
strictly prefers `p`, and another utility that strictly prefers `q`.
-/


end BookProof.ChapterNoBestPrior
