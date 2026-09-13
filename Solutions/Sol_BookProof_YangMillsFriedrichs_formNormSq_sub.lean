-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.formNormSq_sub
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_YangMillsFriedrichs_formInner_real_smul_left
import Theorems.Thm_BookProof_YangMillsFriedrichs_formInner_real_smul_right
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_add
import Definitions.Def_ChapterFarisLavine
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    formNormSq H (x - y)
      = formNormSq H x - 2 * (formInner H x y).re + formNormSq H y := by

  have h : x - y = x + ((-1 : ℝ) : ℂ) • y := by
    push_cast
    module
  rw [h, formNormSq_add hsym]
  have h1 : formInner H x (((-1 : ℝ) : ℂ) • y) = ((-1 : ℝ) : ℂ) * formInner H x y :=
    formInner_real_smul_right H (-1) x y
  have h2 : formNormSq H (((-1 : ℝ) : ℂ) • y) = formNormSq H y := by
    simp only [formNormSq, formInner_real_smul_left, formInner_real_smul_right]
    push_cast
    ring_nf
  rw [h1, h2]
  push_cast
  simp
  ring
