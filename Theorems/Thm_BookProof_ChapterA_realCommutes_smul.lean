-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.realCommutes_smul
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.realCommutes_smul {M : System ℂ V} {S : V →L[ℝ] V} (hS : RealCommutes M S)
    (r : ℝ) : RealCommutes M (r • S) := by sorry
