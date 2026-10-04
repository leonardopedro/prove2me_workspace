-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.cliff_anticomm
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.cliff_anticomm (hA : IsCliffordC A) {μ ν : Fin 4} (h : μ ≠ ν) :
    A μ * A ν = -(A ν * A μ) := by sorry
