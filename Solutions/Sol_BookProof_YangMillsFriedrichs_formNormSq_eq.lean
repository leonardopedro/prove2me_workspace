-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.formNormSq_eq
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (H : D →ₗ[ℂ] F) (x : D) :
    formNormSq H x = ‖(x : F)‖ ^ 2 + quadForm H x := by

  have h : (inner ℂ (x : F) (x : F) : ℂ).re = ‖(x : F)‖ ^ 2 := by
    simpa using inner_self_eq_norm_sq (𝕜 := ℂ) (x : F)
  simp only [formNormSq, formInner, Complex.add_re, quadForm, h]
