-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.cliff_sq
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4
open BookProof.ChapterA3

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.cliff_sq (hA : IsCliffordC A) (μ : Fin 4) :
    A μ * A μ = (if μ = 0 then (-1 : ℂ) else 1) • (1 : M4) := by sorry
