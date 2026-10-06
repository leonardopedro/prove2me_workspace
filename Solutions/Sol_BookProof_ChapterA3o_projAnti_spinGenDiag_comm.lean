-- Generated from ChapterA3o.lean — solution of BookProof.ChapterA3o.projAnti_spinGenDiag_comm
import Mathlib
import Definitions.Def_ChapterA3o
import Theorems.Thm_BookProof_ChapterA3o_projAnti_diagGen_comm
open BookProof.ChapterA3o



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (μ ν : Fin 4) :
    projAnti N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projAnti N := projAnti_diagGen_comm _
