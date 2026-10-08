-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.G_traceOrth
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.G_traceOrth (S T : Finset (Fin 4)) :
    (G S * (G T)ᵀ).trace = if S = T then 4 else 0 := by sorry
