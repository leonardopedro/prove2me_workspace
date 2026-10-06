-- Generated from ChapterA3o.lean — theorem BookProof.ChapterA3o.projAnti_spinGenDiag_comm
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA3o
import Definitions.Def_ChapterA3j
import Definitions.Def_ChapterA3n
open BookProof.ChapterA3j
open BookProof.ChapterA3n
open BookProof.ChapterA3o


open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n

theorem BookProof.ChapterA3o.projAnti_spinGenDiag_comm {N : ℕ} (μ ν : Fin 4) :
    projAnti N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projAnti N := by sorry
