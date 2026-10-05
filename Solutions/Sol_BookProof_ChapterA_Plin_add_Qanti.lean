-- Generated from ChapterA2c.lean — solution of BookProof.ChapterA.Plin_add_Qanti
import Mathlib
import Definitions.Def_ChapterA2c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace Quaternion


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (S : V →L[ℝ] V) : Plin S + Qanti S = S := by

  simp only [Plin, Qanti, smul_add, smul_sub]
  abel_nf
  module
