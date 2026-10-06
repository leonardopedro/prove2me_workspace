-- Generated from ChapterGellMann.lean — solution of BookProof.ChapterGellMann.gellMann_trace_zero
import Mathlib
import Definitions.Def_ChapterGellMann
open BookProof.ChapterGellMann



open Matrix


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 8) : (gellMann a).trace = 0 := by

  fin_cases a <;>
    simp [gellMann, Matrix.trace, Matrix.diag, Fin.sum_univ_three, Matrix.smul_apply] ;
    ring
