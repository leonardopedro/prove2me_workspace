-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.cembed_apply
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (x : V) : (cembed c : V →L[ℝ] V) x = c • x := by

  rw [cembed, Complex.lift_apply, Complex.liftAux_apply]
  simp only [ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
    Algebra.algebraMap_eq_smul_one, ContinuousLinearMap.one_apply, mulI_apply]
  rw [← Complex.coe_smul, ← Complex.coe_smul, smul_smul, ← add_smul, Complex.re_add_im]
