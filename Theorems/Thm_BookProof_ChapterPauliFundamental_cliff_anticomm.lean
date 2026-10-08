-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.cliff_anticomm
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.cliff_anticomm (hA : IsCliffordC A) {μ ν : Fin 4} (h : μ ≠ ν) :
    A μ * A ν = -(A ν * A μ) := by sorry
