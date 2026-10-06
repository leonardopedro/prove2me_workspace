-- Generated from ChapterLorentzRealRepSum.lean — solution of BookProof.ChapterLorentzRealRepSum.gram_allR
import Mathlib
import Definitions.Def_ChapterLorentzRealRepSum
import Theorems.Thm_BookProof_ChapterLorentzRealRepSum_gram_all
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_mul
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_trace
import Theorems.Thm_BookProof_ChapterLorentzRealRep_castR_transpose
open BookProof.ChapterLorentzRealRepSum



open Matrix


open BookProof.ChapterA3 BookProof.ChapterPinOmega BookProof.ChapterLorentzRealRep
open Module

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ i j : Fin 14, ((bAllR i)ᵀ * bAllR j).trace = if i = j then (4 : ℝ) else 0 := by

  intro i j
  rw [bAllR, bAllR, ← castR_transpose, ← castR_mul, castR_trace, gram_all]
  split_ifs <;> norm_num
