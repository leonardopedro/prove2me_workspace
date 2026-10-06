-- Generated from ChapterFiniteArithmeticPrior.lean — theorem BookProof.ChapterFiniteArithmeticPrior.prior_is_probability
import Mathlib
import Definitions.Def_ChapterFiniteArithmeticPrior
open BookProof.ChapterFiniteArithmeticPrior

theorem BookProof.ChapterFiniteArithmeticPrior.prior_is_probability {B : ℕ} {H : Type*} [Fintype H]
    (E : BayesianArithmeticExtension B H) :
    (∀ h, 0 ≤ E.prior h) ∧ ∑ h, E.prior h = 1 := by sorry
