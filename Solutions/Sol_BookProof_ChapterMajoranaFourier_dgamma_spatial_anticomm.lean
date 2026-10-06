-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.dgamma_spatial_anticomm
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Theorems.Thm_BookProof_ChapterA3_dgamma_clifford
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) (h : i ≠ j) :
    dgamma i.succ * dgamma j.succ = -(dgamma j.succ * dgamma i.succ) := by

      have := BookProof.ChapterA3.dgamma_clifford i.succ j.succ;
      simp_all only [ne_eq, minkowski, minkowskiZ, Fin.succ_inj, ↓reduceIte, Int.cast_zero,
          mul_zero, zero_smul];
      exact eq_neg_of_add_eq_zero_left this
