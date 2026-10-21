-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.inter_isUnit
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_inter_intertwines
import Theorems.Thm_BookProof_ChapterPauliFundamental_intertwiner_isUnit
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution (hA : IsCliffordC A) {F : M4} (hF : inter A F ≠ 0) :
    IsUnit (inter A F).det := intertwiner_isUnit hF (fun μ => inter_intertwines hA F μ)
