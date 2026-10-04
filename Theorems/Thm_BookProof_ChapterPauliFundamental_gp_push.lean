-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.gp_push
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.gp_push (hA : IsCliffordC A) (μ : Fin 4) :
    ∀ l : List (Fin 4), (∀ ν ∈ l, ν ≠ μ) →
      A μ * gp A l = ((-1 : ℂ) ^ l.length) • (gp A l * A μ) := by sorry
