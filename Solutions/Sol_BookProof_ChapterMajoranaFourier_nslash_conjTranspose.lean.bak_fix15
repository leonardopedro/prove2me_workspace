-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.nslash_conjTranspose
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Theorems.Thm_BookProof_ChapterMajoranaFourier_dgamma_conjTranspose
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (n : Fin 3 → ℝ) : (nslash n)ᴴ = -nslash n := by

  unfold nslash; simp only [Complex.coe_smul, conjTranspose_sum, conjTranspose_smul, star_trivial] ;
  rw [ ← Finset.sum_neg_distrib ] ; congr ; ext i ; rw [ dgamma_conjTranspose ] ; aesop;
