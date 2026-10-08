-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.cliff_sq
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

theorem BookProof.ChapterPauliFundamental.cliff_sq (hA : IsCliffordC A) (μ : Fin 4) :
    A μ * A μ = (if μ = 0 then (-1 : ℂ) else 1) • (1 : M4) := by sorry
