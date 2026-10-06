-- Generated from ChapterLorentzRealRepFull.lean — solution of BookProof.ChapterLorentzRealRepFull.gram_fullR
import Mathlib
import Definitions.Def_ChapterLorentzRealRepFull
import Theorems.Thm_BookProof_ChapterLorentzRealRepFull_gram_full
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_mul
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_trace
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_transpose
open BookProof.ChapterLorentzRealRepFull



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open BookProof.ChapterLorentzRealRepSum
open Module

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ i j : Fin 16, ((bFullR i)ᵀ * bFullR j).trace = if i = j then (4 : ℝ) else 0 := by

  intro i j
  rw [bFullR, bFullR, ← castR_transpose, ← castR_mul, castR_trace, gram_full]
  split_ifs <;> norm_num
