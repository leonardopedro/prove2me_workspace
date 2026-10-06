-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.adBoost_mem_lorentzLie
import Mathlib
import Definitions.Def_ChapterA3e
import Theorems.Thm_BookProof_ChapterA3_lorentzLie_of_intModel
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : adBoost j ∈ LorentzLie := by

  have h : adBoostZ j * minkowskiMatZ + minkowskiMatZ * (adBoostZ j)ᵀ = 0 := by
    fin_cases j <;> decide
  exact lorentzLie_of_intModel (adBoostZ j) h
