-- Generated from ChapterA3o.lean — solution of BookProof.ChapterA3o.projAnti_parityDiag_comm
import Mathlib
import Definitions.Def_ChapterA3o
import Theorems.Thm_BookProof_ChapterA3o_projAnti_uniform_comm
open BookProof.ChapterA3o



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} :
    projAnti N * uniform (mgamma 0) = uniform (mgamma 0) * projAnti N := projAnti_uniform_comm _
