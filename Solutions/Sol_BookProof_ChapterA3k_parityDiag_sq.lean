-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.parityDiag_sq
import Mathlib
import Definitions.Def_ChapterA3k
import Theorems.Thm_BookProof_ChapterA3_mgamma_clifford
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution : parityDiag * parityDiag = 1 := by

  have h_mgamma0_sq : mgamma 0 * mgamma 0 = -1 := by
    have h := mgamma_clifford 0 0
    norm_num [minkowski, minkowskiZ] at h
    linear_combination (norm := module) (2⁻¹ : ℂ) • h
  unfold parityDiag
  rw [← mul_kronecker_mul, h_mgamma0_sq,
      ← neg_one_smul ℂ (1 : Matrix (Fin 4) (Fin 4) ℂ),
      smul_kronecker, kronecker_smul, one_kronecker_one, smul_smul]
  norm_num
