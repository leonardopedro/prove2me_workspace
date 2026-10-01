import Definitions.Def_ChapterBayesInference
import Mathlib


/-!
# Bayesian objectives in "Aligned deep learning as a random sampling method"

This file formalizes the finite algebraic content of `book.tex` lines 9731–9854.
The chapter observes that systematic uncertainty is a Bayesian prior and that
its logarithm can be added to the score optimized during learning.  The precise
statement is the standard equivalence between maximum a posteriori estimation
and maximizing `log likelihood + log prior`.

The surrounding engineering and empirical claims are not encoded as theorems.
-/

namespace BookProof.ChapterDeepLearningMAP

variable {Model Data : Type*}

/-- Unnormalized posterior weight. -/
def posteriorWeight (prior : Model → ℝ) (likelihood : Model → Data → ℝ)
    (d : Data) (m : Model) : ℝ := prior m * likelihood m d

/-- Logarithmic MAP objective: log prior plus log likelihood. -/
noncomputable def logObjective (prior : Model → ℝ)
    (likelihood : Model → Data → ℝ) (d : Data) (m : Model) : ℝ :=
  Real.log (prior m) + Real.log (likelihood m d)

/-
For positive prior and likelihood, exponentiating the additive logarithmic
objective recovers the unnormalized posterior weight.
-/


/-
Maximizing `log prior + log likelihood` is exactly maximizing the
unnormalized posterior weight.
-/


variable [Fintype Model]

/-
Division by the common positive evidence does not change the ordering of
models, so MAP can be computed without evaluating the normalization term.
-/


/-
A model maximizes the logarithmic objective iff it maximizes the normalized
posterior.
-/


end BookProof.ChapterDeepLearningMAP
