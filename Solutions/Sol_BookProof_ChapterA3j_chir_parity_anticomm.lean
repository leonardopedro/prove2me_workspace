-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.chir_parity_anticomm
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3j_chir_mgamma_anticomm
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    chir * mgamma 0 = -(mgamma 0 * chir) := chir_mgamma_anticomm 0
