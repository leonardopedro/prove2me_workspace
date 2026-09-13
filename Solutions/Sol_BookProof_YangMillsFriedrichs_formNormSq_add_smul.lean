-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.formNormSq_add_smul
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
theorem solution {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (t : ℝ) (x y : D) :
    formNormSq H (x + (t : ℂ) • y)
      = formNormSq H x + 2 * t * (formInner H x y).re + t ^ 2 * formNormSq H y := by

  rw [formNormSq_add hsym]
  have h1 : formInner H x ((t : ℂ) • y) = (t : ℂ) * formInner H x y :=
    formInner_real_smul_right H t x y
  have h2 : formNormSq H ((t : ℂ) • y) = t ^ 2 * formNormSq H y := by
    simp only [formNormSq, formInner_real_smul_left, formInner_real_smul_right]
    rw [show ((t : ℂ) * ((t : ℂ) * formInner H y y)) = ((t ^ 2 : ℝ) : ℂ) * formInner H y y by
      push_cast; ring, Complex.re_ofReal_mul]
  rw [h1, h2, Complex.mul_re]
  simp
  ring
