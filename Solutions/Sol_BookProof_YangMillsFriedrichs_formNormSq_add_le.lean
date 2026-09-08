-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.formNormSq_add_le
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_nonneg
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_add
import Theorems.Thm_BookProof_YangMillsFriedrichs_formNormSq_sub
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (x y : D) :
    formNormSq H (x + y) ≤ 2 * formNormSq H x + 2 * formNormSq H y := by

  have h := formNormSq_sub hsym x y
  have hnn : 0 ≤ formNormSq H (x - y) := formNormSq_nonneg hpos _
  have := formNormSq_add hsym x y
  linarith
