-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.G_transpose_mul
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

theorem BookProof.ChapterPauliFundamental.G_transpose_mul (μ : Fin 4) (T : Finset (Fin 4)) :
    (G T)ᵀ * mgamma μ = sgnT μ (stepT μ T) • (G (stepT μ T))ᵀ := by sorry
