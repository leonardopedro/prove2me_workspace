-- Generated from ChapterA1b.lean — solution of BookProof.Complexification.Cx.complexify_cxConj_invariant
import Mathlib
import Definitions.Def_ChapterA1b
import Theorems.Thm_BookProof_Complexification_Cx_mem_complexify
open BookProof.Complexification



open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (Y : Submodule ℝ W) :
    ∀ x ∈ complexify Y, cxConj x ∈ complexify Y := by

  intro x hx
  simp only [mem_complexify, cxConj_apply] at *
  exact ⟨hx.1, Y.neg_mem hx.2⟩
