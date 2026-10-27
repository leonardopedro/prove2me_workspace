-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.qembed_apply
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = -x) (q : Quaternion ℝ) :
    qembed θ hθ q
      = algebraMap ℝ (V →L[ℝ] V) q.re + q.imI • mulI + q.imJ • thetaR θ
        + q.imK • (mulI * thetaR θ) := rfl
