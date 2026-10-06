-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.chir_mgamma_anticomm
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3_mgamma5_anticomm
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    chir * mgamma μ = -(mgamma μ * chir) := eq_neg_of_add_eq_zero_left (mgamma5_anticomm μ)
