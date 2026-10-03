-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.stepT_involutive
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA4

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.stepT_involutive : ∀ (μ : Fin 4) (T : Finset (Fin 4)), stepT μ (stepT μ T) = T := by sorry
