-- Generated from ChapterA3x.lean — solution of BookProof.ChapterA3x.projMixed_spinGenDiag_comm
import Mathlib
import Definitions.Def_ChapterA3x
import Theorems.Thm_BookProof_ChapterA3x_projMixed_diagGen_comm
open BookProof.ChapterA3x



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (μ ν : Fin 4) :
    projMixed N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projMixed N := projMixed_diagGen_comm _
