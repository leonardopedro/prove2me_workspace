-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.gram_halfPsR
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_gram_halfPs
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_mul
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_trace
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_transpose
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (i j : Fin 4), ((bHalfR i)ᵀ * bPsR j).trace = (0 : ℝ) := by

  intro i j
  rw [bHalfR, bPsR, ← castR_transpose, ← castR_mul, castR_trace, gram_halfPs]
  norm_num
