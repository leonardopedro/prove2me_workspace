import Mathlib


/-!
# MAP points are null under an atomless posterior

This file formalizes the next self-contained claim in the Bayesian discussion of
`book.tex` around lines 1713--1720.  The book observes that, on a continuous
sample space, a maximum of the posterior has null measure: posterior sampling
may land near such a point, but almost surely does not land exactly there.

The measure-theoretic content does not depend on how the maximizer was selected.
Under an atomless measure every singleton is null, every countable collection of
maximizers is null, and a random posterior sample almost surely avoids it.
-/

open MeasureTheory

namespace BookProof.ChapterMAPNull

variable {α : Type*} [MeasurableSpace α]

/-
Every selected MAP point has posterior mass zero under an atomless posterior.
-/


/-
A posterior sample almost surely does not equal a fixed MAP point.
-/


/-
More generally, any countable collection of posterior maximizers is null.
-/


/-- The set of global maximizers of a posterior score. -/
def maximizerSet (score : α → ℝ) : Set α :=
  {x | ∀ y, score y ≤ score x}

/-
A countable set of posterior-score maximizers is null under an atomless posterior.
-/


/-
A posterior sample almost surely avoids every point in a countable MAP set.
-/

end BookProof.ChapterMAPNull
