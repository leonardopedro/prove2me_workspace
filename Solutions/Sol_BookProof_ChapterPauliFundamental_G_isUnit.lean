-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.G_isUnit
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_G_orthogonal
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution (T : Finset (Fin 4)) : IsUnit (G T).det := Matrix.isUnit_det_of_right_inverse (G_orthogonal T)
