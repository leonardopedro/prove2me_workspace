-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.formInner_real_smul_left
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (H : D →ₗ[ℂ] F) (t : ℝ) (x y : D) :
    formInner H ((t : ℂ) • x) y = (t : ℂ) * formInner H x y := by

  simp only [formInner, Submodule.coe_smul, inner_smul_left, Complex.conj_ofReal]
  ring
