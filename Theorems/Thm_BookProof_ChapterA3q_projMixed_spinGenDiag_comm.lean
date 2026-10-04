-- Generated from ChapterA3q.lean — theorem BookProof.ChapterA3q.projMixed_spinGenDiag_comm
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3o
import Mathlib
import Definitions.Def_ChapterA3q
import Definitions.Def_ChapterA3j
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterA4
open BookProof.ChapterA3j
open BookProof.ChapterA3n
open BookProof.ChapterA3q


open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o

theorem BookProof.ChapterA3q.projMixed_spinGenDiag_comm {N : ℕ} (μ ν : Fin 4) :
    projMixed N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projMixed N := by sorry
