-- Generated from ChapterA1h.lean — solution of BookProof.ChapterA.rImagCx_sq
import Mathlib
import Definitions.Def_ChapterA1h
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℝ W} {J : W ≃ₗᵢ[ℝ] W} (hJ : IsRImaginary M J) (x : Cx W) :
    rImagCx J (rImagCx J x) = -x := by

  ext <;> simp [rImagCx_apply, hJ.1]
