-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.Plin_realCommutes
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.Plin_realCommutes {M : System ℂ V} {S : V →L[ℝ] V} (hS : RealCommutes M S) :
    RealCommutes M (Plin S) := by sorry
