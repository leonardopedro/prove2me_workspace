-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.gram_two_10R
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_gram_two_10
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_mul
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_trace
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_transpose
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (i : Fin 2) (j : Fin 6), ((w2R i)ᵀ * b10R j).trace = (0 : ℝ) := by

  intro i j
  rw [w2R, b10R, ← castR_transpose, ← castR_mul, castR_trace, gram_two_10]
  norm_num
