-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.Qanti_mulI_comm
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.Qanti_mulI_comm (S : V →L[ℝ] V) : mulI * Qanti S = -(Qanti S * mulI) := by sorry
