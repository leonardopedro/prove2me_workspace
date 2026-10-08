-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.stepT_involutive
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.stepT_involutive : ∀ (μ : Fin 4) (T : Finset (Fin 4)), stepT μ (stepT μ T) = T := by sorry
