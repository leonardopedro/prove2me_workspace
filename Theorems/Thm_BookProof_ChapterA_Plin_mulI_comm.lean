-- Generated from ChapterA2c.lean — theorem BookProof.ChapterA.Plin_mulI_comm
import Mathlib
import Definitions.Def_ChapterA2c
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace Quaternion



theorem BookProof.ChapterA.Plin_mulI_comm (S : V →L[ℝ] V) : mulI * Plin S = Plin S * mulI := by sorry
