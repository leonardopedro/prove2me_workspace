import Mathlib
import BookProof.ChapterBayesInference

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
theorem exp_logObjective (prior : Model → ℝ) (likelihood : Model → Data → ℝ)
    (d : Data) (hprior : ∀ m, 0 < prior m)
    (hlike : ∀ m, 0 < likelihood m d) (m : Model) :
    Real.exp (logObjective prior likelihood d m) =
      posteriorWeight prior likelihood d m := by
  unfold logObjective posteriorWeight
  rw [Real.exp_add, Real.exp_log (hprior m), Real.exp_log (hlike m)]

/-
Maximizing `log prior + log likelihood` is exactly maximizing the
unnormalized posterior weight.
-/
theorem logObjective_le_iff (prior : Model → ℝ)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hprior : ∀ m, 0 < prior m) (hlike : ∀ m, 0 < likelihood m d)
    (a b : Model) :
    logObjective prior likelihood d a ≤ logObjective prior likelihood d b ↔
      posteriorWeight prior likelihood d a ≤ posteriorWeight prior likelihood d b := by
  rw [← exp_logObjective _ _ _ hprior hlike,
    ← exp_logObjective _ _ _ hprior hlike, Real.exp_le_exp]

variable [Fintype Model]

/-
Division by the common positive evidence does not change the ordering of
models, so MAP can be computed without evaluating the normalization term.
-/
theorem posterior_le_iff_weight (prior : Model → ℝ)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence prior likelihood d)
    (a b : Model) :
    BookProof.ChapterBayesInference.posterior prior likelihood d a ≤
      BookProof.ChapterBayesInference.posterior prior likelihood d b ↔
    posteriorWeight prior likelihood d a ≤ posteriorWeight prior likelihood d b := by
  unfold ChapterBayesInference.posterior
  rw [div_le_div_iff_of_pos_right hevidence]
  rfl

/-
A model maximizes the logarithmic objective iff it maximizes the normalized
posterior.
-/
theorem isMAP_iff_maximizes_logObjective (prior : Model → ℝ)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hprior : ∀ m, 0 < prior m) (hlike : ∀ m, 0 < likelihood m d)
    (hevidence : 0 < BookProof.ChapterBayesInference.evidence prior likelihood d)
    (best : Model) :
    (∀ m, BookProof.ChapterBayesInference.posterior prior likelihood d m ≤
      BookProof.ChapterBayesInference.posterior prior likelihood d best) ↔
    (∀ m, logObjective prior likelihood d m ≤
      logObjective prior likelihood d best) := by
  constructor
  · intro h m
    exact (logObjective_le_iff prior likelihood d hprior hlike m best).mpr
      ((posterior_le_iff_weight prior likelihood d hevidence m best).mp (h m))
  · intro h m
    apply (posterior_le_iff_weight prior likelihood d hevidence m best).mpr
    exact (logObjective_le_iff prior likelihood d hprior hlike m best).mp (h m)

end BookProof.ChapterDeepLearningMAP
