-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.realPart_complexify
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_mem_complexify
import Theorems.Thm_BookProof_Complexification_Cx_mem_realPart



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (Y : Submodule ℝ W) : realPart (complexify Y) = Y := by

  ext w
  simp only [mem_realPart, mem_complexify, ofReal_re, ofReal_im]
  constructor
  · rintro ⟨h, _⟩; exact h
  · intro h; exact ⟨h, Y.zero_mem⟩
