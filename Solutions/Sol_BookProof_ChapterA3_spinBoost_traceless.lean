-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.spinBoost_traceless
import Mathlib
import Definitions.Def_ChapterA3e
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : (spinBoost j).trace = 0 := by

  have h : (spinBoostZ j).trace = 0 := by fin_cases j <;> decide
  have he : (spinBoost j).trace = (Int.castRingHom ℝ) ((spinBoostZ j).trace) := by
    simp [spinBoost, Matrix.trace, Matrix.diag, RingHom.mapMatrix_apply,
      Matrix.map_apply, map_sum]
  rw [he, h, map_zero]
