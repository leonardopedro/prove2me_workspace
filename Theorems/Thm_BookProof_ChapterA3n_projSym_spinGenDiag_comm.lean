-- Generated from ChapterA3n.lean — theorem BookProof.ChapterA3n.projSym_spinGenDiag_comm
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterA3j
import Definitions.Def_ChapterA3l
open BookProof.ChapterA3j
open BookProof.ChapterA3l
open BookProof.ChapterA3n


open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

theorem BookProof.ChapterA3n.projSym_spinGenDiag_comm {N : ℕ} (μ ν : Fin 4) :
    projSym N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projSym N := by sorry
