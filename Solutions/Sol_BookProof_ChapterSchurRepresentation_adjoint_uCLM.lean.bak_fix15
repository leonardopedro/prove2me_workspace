-- Generated from ChapterSchurRepresentation.lean — solution of BookProof.ChapterSchurRepresentation.adjoint_uCLM
import Mathlib
import Definitions.Def_ChapterSchurRepresentation
open BookProof.ChapterSchurRepresentation



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (f : V ≃ₗᵢ[ℂ] V) :
    ContinuousLinearMap.adjoint (uCLM f) = uCLM f.symm := by

  refine ((ContinuousLinearMap.eq_adjoint_iff _ _).mpr ?_).symm
  intro x y
  change ⟪f.symm x, y⟫_ℂ = ⟪x, f y⟫_ℂ
  rw [← f.inner_map_map (f.symm x) y, f.apply_symm_apply]
