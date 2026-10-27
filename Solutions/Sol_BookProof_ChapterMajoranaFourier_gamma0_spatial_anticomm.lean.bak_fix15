-- Generated from ChapterMajoranaFourier.lean — solution of BookProof.ChapterMajoranaFourier.gamma0_spatial_anticomm
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
import Theorems.Thm_BookProof_ChapterA3_dgamma_clifford
open BookProof.ChapterMajoranaFourier



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin 3) :
    dgamma 0 * dgamma i.succ = -(dgamma i.succ * dgamma 0) := by

      have := BookProof.ChapterA3.dgamma_clifford 0 ( Fin.succ i );
      simp_all only [Fin.isValue, minkowski, minkowskiZ, ↓reduceIte, Int.cast_ite, Int.cast_one,
          Int.cast_zero, mul_ite, mul_one, mul_zero, ite_smul, zero_smul];
      exact eq_neg_of_add_eq_zero_left ( this.trans ( by fin_cases i <;> rfl ) )
