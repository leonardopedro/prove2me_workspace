-- Generated from ChapterGellMann.lean — solution of BookProof.ChapterGellMann.gellMann_trace_orthonormal
import Mathlib
import Definitions.Def_ChapterGellMann
open BookProof.ChapterGellMann



open Matrix


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution (a b : Fin 8) :
    (gellMann a * gellMann b).trace = (if a = b then (2 : ℂ) else 0) := by

  have h3 : (Real.sqrt 3) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  fin_cases a <;> fin_cases b <;>
    simp [gellMann, Matrix.trace, Matrix.diag, Matrix.mul_apply, Fin.sum_univ_three,
      Complex.ext_iff] <;>
    norm_num [Complex.ext_iff] ;
    nlinarith [h3, Real.sqrt_nonneg 3]
