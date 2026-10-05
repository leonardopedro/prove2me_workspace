-- Generated from ChapterA3x.lean — solution of BookProof.ChapterA3x.projMixed_parityDiag_comm
import Mathlib
import Definitions.Def_ChapterA3x
import Theorems.Thm_BookProof_ChapterA3x_projMixed_uniform_comm
open BookProof.ChapterA3x



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} :
    projMixed N * uniform (mgamma 0) = uniform (mgamma 0) * projMixed N := projMixed_uniform_comm _
