-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.complexify_top
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_mem_complexify



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution : complexify (⊤ : Submodule ℝ W) = ⊤ := by

  ext x; simp
