-- Generated from ChapterA3e.lean — solution of BookProof.ChapterA3.spinRot_traceless
import Mathlib
import Definitions.Def_ChapterA3e
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : (spinRot j).trace = 0 := by

  have h : (spinRotZ j).trace = 0 := by fin_cases j <;> decide
  have he : (spinRot j).trace = (Int.castRingHom ℝ) ((spinRotZ j).trace) := by
    simp [spinRot, Matrix.trace, Matrix.diag, RingHom.mapMatrix_apply,
      Matrix.map_apply, map_sum]
  rw [he, h, map_zero]
