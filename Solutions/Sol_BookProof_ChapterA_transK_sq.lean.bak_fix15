-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.transK_sq
import Mathlib
import Definitions.Def_ChapterA2e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution (β : V ≃ₗᵢ[ℝ] W) : (transK β) * (transK β) = -1 := by

  ext w
  simp only [ContinuousLinearMap.mul_apply, transK_apply, LinearIsometryEquiv.symm_apply_apply,
    ContinuousLinearMap.neg_apply, ContinuousLinearMap.one_apply, smul_smul, Complex.I_mul_I,
    neg_one_smul, map_neg, LinearIsometryEquiv.apply_symm_apply]
