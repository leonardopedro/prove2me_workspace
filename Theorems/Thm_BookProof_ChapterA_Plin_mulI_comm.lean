-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.Plin_mulI_comm
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.Plin_mulI_comm (S : V →L[ℝ] V) : mulI * Plin S = Plin S * mulI := by sorry
