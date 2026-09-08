-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.formNormSq_add
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_YangMillsFriedrichs_re_formInner_swap
import Theorems.Thm_BookProof_YangMillsFriedrichs_formInner_add_left
import Theorems.Thm_BookProof_YangMillsFriedrichs_formInner_add_right
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (x y : D) :
    formNormSq H (x + y)
      = formNormSq H x + 2 * (formInner H x y).re + formNormSq H y := by

  simp only [formNormSq, formInner_add_left, formInner_add_right, Complex.add_re]
  rw [re_formInner_swap hsym x y]
  ring
