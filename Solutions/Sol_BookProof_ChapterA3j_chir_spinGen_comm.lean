-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.chir_spinGen_comm
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3j_chir_mgamma_anticomm
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) :
    chir * spinGen μ ν = spinGen μ ν * chir := by

  rw [spinGen, ← mul_assoc, chir_mgamma_anticomm μ, neg_mul, mul_assoc,
    chir_mgamma_anticomm ν, mul_neg, neg_neg, mul_assoc]
