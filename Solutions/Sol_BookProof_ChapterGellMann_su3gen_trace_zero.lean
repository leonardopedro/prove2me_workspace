-- Generated from ChapterGellMann.lean — solution of BookProof.ChapterGellMann.su3gen_trace_zero
import Mathlib
import Definitions.Def_ChapterGellMann
import Theorems.Thm_BookProof_ChapterGellMann_gellMann_trace_zero
open BookProof.ChapterGellMann



open Matrix


open BookProof.ChapterParity

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin 8) : (su3gen a).trace = 0 := by

  simp [su3gen, Matrix.trace_smul, gellMann_trace_zero a]
