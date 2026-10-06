-- Generated from ChapterA3n.lean — solution of BookProof.ChapterA3n.projSym_parityDiag_comm
import Mathlib
import Definitions.Def_ChapterA3n
import Theorems.Thm_BookProof_ChapterA3n_projSym_uniform_comm
open BookProof.ChapterA3n



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} :
    projSym N * uniform (mgamma 0) = uniform (mgamma 0) * projSym N := projSym_uniform_comm _
