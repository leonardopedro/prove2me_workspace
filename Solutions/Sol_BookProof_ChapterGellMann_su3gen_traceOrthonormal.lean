-- Generated from ChapterGellMann.lean — solution of BookProof.ChapterGellMann.su3gen_traceOrthonormal
import Mathlib
import Definitions.Def_ChapterGellMann
import Theorems.Thm_BookProof_ChapterGellMann_gellMann_trace_orthonormal
open BookProof.ChapterGellMann



open Matrix


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution : YangMillsSU3.TraceOrthonormal su3gen := by

  intro a b
  have h : su3gen a * su3gen b = (1 / 4 : ℂ) • (gellMann a * gellMann b) := by
    simp only [su3gen, smul_mul_smul_comm]; norm_num
  rw [h, Matrix.trace_smul, gellMann_trace_orthonormal]
  by_cases hab : a = b <;> simp only [hab, if_true, if_false, smul_eq_mul] <;> norm_num
