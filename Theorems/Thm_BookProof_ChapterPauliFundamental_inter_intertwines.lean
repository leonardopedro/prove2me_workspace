-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.inter_intertwines
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

theorem BookProof.ChapterPauliFundamental.inter_intertwines (hA : IsCliffordC A) (F : M4) (μ : Fin 4) :
    A μ * inter A F = inter A F * mgamma μ := by sorry
