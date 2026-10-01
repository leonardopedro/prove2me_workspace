-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weylOp_apply
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]



open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

 D →ₗ[ℂ] D) (x : D) :
    weylOp pi Bf x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ i, ((pi i (pi i x) : D) : F)) + ∑ a, ((Bf a (Bf a x) : D) : F)) := by
  simp [weylOp, weylOpDom]

/-- The square of a symmetric operator has quadratic form `‖π x‖²`. -/
th := by sorry
