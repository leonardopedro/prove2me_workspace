-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.G_inv
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_G_orthogonal
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution (T : Finset (Fin 4)) : (G T)⁻¹ = (G T)ᵀ := Matrix.inv_eq_right_inv (G_orthogonal T)
