-- Generated from ChapterA3m.lean — theorem BookProof.ChapterA3m.swap12_spinGenDiag_comm
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3k
import Definitions.Def_ChapterA3l
import Mathlib
import Definitions.Def_ChapterA3m
import Definitions.Def_ChapterA3j
open BookProof.ChapterA3j
open BookProof.ChapterA3m


open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

theorem BookProof.ChapterA3m.swap12_spinGenDiag_comm (μ ν : Fin 4) :
    swap12 * spinGenDiag3 μ ν = spinGenDiag3 μ ν * swap12 := by sorry
