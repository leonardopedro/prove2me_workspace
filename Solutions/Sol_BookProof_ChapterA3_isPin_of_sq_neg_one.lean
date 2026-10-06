-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.isPin_of_sq_neg_one
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_det_sq_of_sq_neg_one
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {S : Matrix (Fin 4) (Fin 4) ℝ} (h : S * S = -1)
    (hL : ∃ Λ, HasLambda S Λ) : IsPin S := by

  have hdet : S.det * S.det = 1 := det_sq_of_sq_neg_one h
  refine ⟨isUnit_iff_ne_zero.mpr (by rintro hz; rw [hz] at hdet; simp at hdet), ?_, hL⟩
  have h2 : |S.det| * |S.det| = 1 := by rw [← abs_mul, hdet, abs_one]
  nlinarith [abs_nonneg S.det, h2]
