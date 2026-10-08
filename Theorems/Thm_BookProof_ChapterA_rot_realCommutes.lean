-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.rot_realCommutes
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterA.rot_realCommutes {N : System ℂ H} {θ : AntiUnitary H}
    (hθc : CommutesAntiUnitary N θ) (p s : ℂ) : RealCommutes N (rot θ p s) := by sorry
