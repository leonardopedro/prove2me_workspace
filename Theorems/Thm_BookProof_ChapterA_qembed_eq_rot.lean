-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.qembed_eq_rot
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterA.qembed_eq_rot (θ : AntiUnitary H) (hθ : ∀ x, θ (θ x) = -x) (q : Quaternion ℝ) :
    qembed θ hθ q = rot θ (q.re + q.imI * Complex.I) (q.imJ + q.imK * Complex.I) := by sorry
