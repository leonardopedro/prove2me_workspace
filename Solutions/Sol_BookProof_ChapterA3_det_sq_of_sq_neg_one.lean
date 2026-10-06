-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.det_sq_of_sq_neg_one
import Mathlib
import Definitions.Def_ChapterA3d
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution {S : Matrix (Fin 4) (Fin 4) ℝ} (h : S * S = -1) :
    S.det * S.det = 1 := by

  have hd := congrArg Matrix.det h
  rw [Matrix.det_mul] at hd
  rw [hd]
  norm_num [Matrix.det_neg, Fintype.card_fin]
