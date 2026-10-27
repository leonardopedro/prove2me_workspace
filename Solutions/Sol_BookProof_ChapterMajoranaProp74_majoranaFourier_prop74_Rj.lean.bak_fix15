-- Generated from ChapterMajoranaProp74.lean — solution of BookProof.ChapterMajoranaProp74.majoranaFourier_prop74_Rj
import Mathlib
import Definitions.Def_ChapterMajoranaProp74
import Theorems.Thm_BookProof_ChapterMajoranaProp74_prop74_Rj_comm
import Theorems.Thm_BookProof_ChapterMajoranaFourier_gamma0_nslash_anticomm
import Theorems.Thm_BookProof_ChapterMajoranaFourier_gamma0_sq
open BookProof.ChapterMajoranaProp74



open Matrix


open BookProof.ChapterMajoranaFourier
open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (n : Fin 3 → ℝ) (c s pj : ℝ) :
    Dmat (dgamma 0) pj * Sinv (Aop n) c s = Sinv (Aop n) c s * Dmat (dgamma 0) pj := by

  exact prop74_Rj_comm (dgamma 0) (nslash n) gamma0_sq (gamma0_nslash_anticomm n) c s pj
