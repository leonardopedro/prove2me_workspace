-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.eq_ofReal_add_smul
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_smul_I
open BookProof.Complexification



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (x : Cx W) : x = ofReal x.re + (Complex.I : ℂ) • ofReal x.im := by

  rw [smul_I]; ext <;> simp
