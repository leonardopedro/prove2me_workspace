-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.qembed_eq_rot
import Mathlib
import Definitions.Def_ChapterA2e
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) (q : Quaternion ℝ) :
    qembed θ hθ q = rot θ (q.re + q.imI * Complex.I) (q.imJ + q.imK * Complex.I) := by

  ext w
  simp only [qembed_apply, ContinuousLinearMap.add_apply, ContinuousLinearMap.smul_apply,
    Algebra.algebraMap_eq_smul_one, ContinuousLinearMap.one_apply, mulI_apply,
    ContinuousLinearMap.mul_apply, thetaR_apply, rot_apply]
  rw [add_smul, add_smul, mul_smul, mul_smul]
  simp only [Complex.coe_smul]; abel
