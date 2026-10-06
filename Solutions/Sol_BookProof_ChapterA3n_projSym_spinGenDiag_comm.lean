-- Generated from ChapterA3n.lean — solution of BookProof.ChapterA3n.projSym_spinGenDiag_comm
import Mathlib
import Definitions.Def_ChapterA3n
import Theorems.Thm_BookProof_ChapterA3n_projSym_diagGen_comm
open BookProof.ChapterA3n



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (μ ν : Fin 4) :
    projSym N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projSym N := projSym_diagGen_comm _
