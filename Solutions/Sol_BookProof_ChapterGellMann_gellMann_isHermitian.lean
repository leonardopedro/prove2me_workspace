-- Generated from ChapterGellMann.lean — solution of BookProof.ChapterGellMann.gellMann_isHermitian
import Mathlib
import Definitions.Def_ChapterGellMann
open BookProof.ChapterGellMann



open Matrix


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 8) : (gellMann a).IsHermitian := by

  fin_cases a <;>
  · ext i j; fin_cases i <;> fin_cases j <;>
      simp [gellMann, Matrix.conjTranspose_apply, Complex.conj_I,
        Matrix.smul_apply, Complex.conj_ofReal]
