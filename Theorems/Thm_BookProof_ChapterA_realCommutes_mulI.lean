-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.realCommutes_mulI
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.realCommutes_mulI (M : System ℂ V) : RealCommutes M (mulI : V →L[ℝ] V) := by sorry
