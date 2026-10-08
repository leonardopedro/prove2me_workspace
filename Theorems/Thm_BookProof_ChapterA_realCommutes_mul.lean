-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.realCommutes_mul
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.realCommutes_mul {M : System ℂ V} {S T : V →L[ℝ] V}
    (hS : RealCommutes M S) (hT : RealCommutes M T) : RealCommutes M (S * T) := by sorry
