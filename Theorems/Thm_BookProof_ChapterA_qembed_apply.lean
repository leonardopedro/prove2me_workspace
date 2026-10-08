-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.qembed_apply
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.qembed_apply (θ : AntiUnitary V) (hθ : ∀ x, θ (θ x) = -x) (q : Quaternion ℝ) :
    qembed θ hθ q
      = algebraMap ℝ (V →L[ℝ] V) q.re + q.imI • mulI + q.imJ • thetaR θ
        + q.imK • (mulI * thetaR θ) := by sorry
