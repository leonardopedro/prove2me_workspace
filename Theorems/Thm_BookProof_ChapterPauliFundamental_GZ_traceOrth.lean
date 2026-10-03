-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.GZ_traceOrth
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA4

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.GZ_traceOrth : ∀ S T : Finset (Fin 4),
    (GZ S * (GZ T)ᵀ).trace = if S = T then 4 else 0 := by sorry
