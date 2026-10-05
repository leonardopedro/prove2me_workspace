-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.GZ_orthogonal
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

theorem BookProof.ChapterPauliFundamental.GZ_orthogonal : ∀ T : Finset (Fin 4), GZ T * (GZ T)ᵀ = 1 := by sorry
