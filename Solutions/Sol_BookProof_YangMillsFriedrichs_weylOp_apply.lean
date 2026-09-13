-- Generated from ChapterYangMillsFriedrichs.lean — solution of BookProof.YangMillsFriedrichs.weylOp_apply
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
open BookProof.YangMillsFriedrichs



















open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}





















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {n m : ℕ} (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) (x : D) :
    weylOp pi Bf x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ i, ((pi i (pi i x) : D) : F)) + ∑ a, ((Bf a (Bf a x) : D) : F)) := by

  simp [weylOp, weylOpDom]
