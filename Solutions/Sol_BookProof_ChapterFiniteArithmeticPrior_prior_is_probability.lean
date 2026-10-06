-- Generated from ChapterFiniteArithmeticPrior.lean — solution of BookProof.ChapterFiniteArithmeticPrior.prior_is_probability
import Mathlib
import Definitions.Def_ChapterFiniteArithmeticPrior
open BookProof.ChapterFiniteArithmeticPrior

set_option maxHeartbeats 1000000 in
theorem solution {B : ℕ} {H : Type*} [Fintype H]
    (E : BayesianArithmeticExtension B H) :
    (∀ h, 0 ≤ E.prior h) ∧ ∑ h, E.prior h = 1 := by

  exact ⟨E.prior_nonneg, E.prior_sum_one⟩
