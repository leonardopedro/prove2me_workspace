-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.realCommutes_thetaR
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.realCommutes_thetaR {M : System ℂ V} {θ : AntiUnitary V}
    (hθ : CommutesAntiUnitary M θ) : RealCommutes M (thetaR θ) := by sorry
