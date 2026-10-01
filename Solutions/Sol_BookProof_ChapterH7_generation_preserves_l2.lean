-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.generation_preserves_l2
import Mathlib
import Definitions.Def_ChapterH7
import Theorems.Thm_BookProof_ChapterH7_generatedState_eq_generationOperator
import Theorems.Thm_BookProof_ChapterH7_generationOperator_conjTranspose_mul
open BookProof.ChapterH7



noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin m) (Fin m) ℂ) (t : ℝ)
    (hA : A.IsHermitian) (psi0 : Fin m → ℂ) :
    ∑ i, Complex.normSq (generatedState A (t : ℂ) psi0 i) = ∑ i, Complex.normSq (psi0 i) := by

  have hU := generationOperator_conjTranspose_mul A t hA
  have key : (star ((generationOperator A t).mulVec psi0)) ⬝ᵥ
      ((generationOperator A t).mulVec psi0) = (star psi0) ⬝ᵥ psi0 := by
    rw [Matrix.star_mulVec, ← Matrix.dotProduct_mulVec, Matrix.mulVec_mulVec, hU,
      Matrix.one_mulVec]
  have hcast : ∀ v : Fin m → ℂ, (star v) ⬝ᵥ v = ((∑ i, Complex.normSq (v i) : ℝ) : ℂ) := by
    intro v
    simp only [dotProduct, Pi.star_apply, RCLike.star_def, Complex.ofReal_sum]
    exact Finset.sum_congr rfl fun i _ => (Complex.normSq_eq_conj_mul_self).symm
  rw [generatedState_eq_generationOperator]
  have := key
  rw [hcast, hcast] at this
  exact_mod_cast this
