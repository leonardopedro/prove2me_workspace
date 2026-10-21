-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.gamma0_nslash_anticomm
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Theorems.Thm_BookProof_ChapterMajoranaFourier_gamma0_spatial_anticomm
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (n : Fin 3 → ℝ) :
    dgamma 0 * nslash n = -(nslash n * dgamma 0) := by

      unfold nslash; simp only [Fin.isValue, Complex.coe_smul, Finset.mul_sum _ _ _,
          Algebra.mul_smul_comm, Finset.sum_mul, Algebra.smul_mul_assoc] ;
      rw [ ← Finset.sum_neg_distrib ] ;        congr ; ext x ; rw [ gamma0_spatial_anticomm ] ; simp
          ;
