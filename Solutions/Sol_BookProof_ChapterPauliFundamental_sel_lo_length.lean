-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.sel_lo_length
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    (sel (lo μ T)).length = (lo μ T).card := by
 decide
