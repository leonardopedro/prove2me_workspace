-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.isPin_mul
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_hasLambda_mul
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution {S₁ S₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (h1 : IsPin S₁) (h2 : IsPin S₂) : IsPin (S₁ * S₂) := by

  -- Show that the determinant of the product is 1.
  have h_det : IsUnit (S₁ * S₂).det ∧ |(S₁ * S₂).det| = 1 := by
    simp_all [ IsPin ]
  generalize_proofs at *;
  exact ⟨ h_det.1, h_det.2, by obtain ⟨ Λ₁, hL1 ⟩ := h1.2.2; obtain ⟨ Λ₂, hL2 ⟩ := h2.2.2; exact ⟨
                               Λ₁ * Λ₂, hasLambda_mul h1.1 h2.1 hL1 hL2 ⟩ ⟩
