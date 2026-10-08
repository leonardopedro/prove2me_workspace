-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.lo_stepT
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.lo_stepT : ∀ (μ : Fin 4) (T : Finset (Fin 4)), lo μ (stepT μ T) = lo μ T := by sorry
