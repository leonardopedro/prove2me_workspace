-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.re_formInner_sq_le
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_nonneg
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_add_smul
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (x y : D) :
    (formInner H x y).re ^ 2 ≤ formNormSq H x * formNormSq H y := by

  set A := formNormSq H x with hA
  set C := formNormSq H y with hC
  set B := (formInner H x y).re with hB
  have hquad : ∀ t : ℝ, 0 ≤ A + 2 * t * B + t ^ 2 * C := by
    intro t
    rw [← formNormSq_add_smul hsym t x y]
    exact formNormSq_nonneg hpos _
  have hCnn : 0 ≤ C := formNormSq_nonneg hpos y
  rcases eq_or_lt_of_le hCnn with hC0 | hCpos
  · -- `C = 0` forces `B = 0`
    have hB0 : B = 0 := by
      by_contra hBne
      have key := hquad (-(A + 1) / (2 * B))
      rw [← hC0] at key
      have hval : A + 2 * (-(A + 1) / (2 * B)) * B + (-(A + 1) / (2 * B)) ^ 2 * 0 = -1 := by
        field_simp
        ring
      rw [hval] at key
      linarith
    rw [hB0, ← hC0]
    simp
  · have h := hquad (-(B / C))
    have hCne : C ≠ 0 := ne_of_gt hCpos
    field_simp at h
    nlinarith [h, hCpos]
