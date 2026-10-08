-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.qembed_realCommutes
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.qembed_realCommutes {M : System ℂ V} {θ : AntiUnitary V} (hθ : ∀ x, θ (θ x) = -x)
    (hθc : CommutesAntiUnitary M θ) (q : Quaternion ℝ) :
    RealCommutes M (qembed θ hθ q) := by sorry
