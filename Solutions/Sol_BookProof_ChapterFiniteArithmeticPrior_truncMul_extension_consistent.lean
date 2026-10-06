-- Generated from ChapterFiniteArithmeticPrior.lean — solution of BookProof.ChapterFiniteArithmeticPrior.truncMul_extension_consistent
import Mathlib
import Definitions.Def_ChapterFiniteArithmeticPrior
import Theorems.Thm_BookProof_ChapterFiniteArithmeticPrior_truncMul_eq_mul
open BookProof.ChapterFiniteArithmeticPrior

set_option maxHeartbeats 1000000 in
theorem solution {B : ℕ} [NeZero B] {H : Type*} [Fintype H]
    (E : BayesianArithmeticExtension B H) (hE : E.known = truncMul B)
    (a b : Fin B) (h : (a : ℕ) * (b : ℕ) < B) :
    ((E.known.result a b : Fin B) : ℕ) = (a : ℕ) * (b : ℕ) ∧
      (∀ x, 0 ≤ E.prior x) ∧ ∑ x, E.prior x = 1 := by

  refine ⟨?_, E.prior_nonneg, E.prior_sum_one⟩
  rw [hE]
  exact truncMul_eq_mul a b h
