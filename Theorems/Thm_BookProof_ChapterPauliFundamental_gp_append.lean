-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.gp_append
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA4
open BookProof.ChapterPauliFundamental


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.gp_append (A : Fin 4 → M4) (l₁ l₂ : List (Fin 4)) :
    gp A (l₁ ++ l₂) = gp A l₁ * gp A l₂ := by sorry
