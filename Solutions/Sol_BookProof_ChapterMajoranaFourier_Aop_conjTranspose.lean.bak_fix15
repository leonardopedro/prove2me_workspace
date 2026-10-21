-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.Aop_conjTranspose
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Theorems.Thm_BookProof_ChapterMajoranaFourier_dgamma_conjTranspose
import Theorems.Thm_BookProof_ChapterMajoranaFourier_nslash_conjTranspose
import Theorems.Thm_BookProof_ChapterMajoranaFourier_gamma0_nslash_anticomm
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (n : Fin 3 → ℝ) : (Aop n)ᴴ = Aop n := by

  unfold Aop; simp only [Fin.isValue, conjTranspose_mul] ;
  rw [ nslash_conjTranspose, dgamma_conjTranspose ] ; norm_num;
  rw [ gamma0_nslash_anticomm, neg_neg ]
