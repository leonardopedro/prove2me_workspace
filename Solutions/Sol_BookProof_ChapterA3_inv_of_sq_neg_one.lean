-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.inv_of_sq_neg_one
import Mathlib
import Definitions.Def_ChapterA3d
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {S : Matrix (Fin 4) (Fin 4) ℝ} (h : S * S = -1) :
    S⁻¹ = -S := by

  apply Matrix.inv_eq_left_inv
  rw [Matrix.neg_mul, h, neg_neg]
