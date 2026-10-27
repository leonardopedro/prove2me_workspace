-- Generated from ChapterParityChirality.lean — solution of BookProof.ChapterParityChirality.QLProj_trace
import Mathlib
import Definitions.Def_ChapterParityChirality
import Theorems.Thm_BookProof_ChapterParityChirality_chi_trace
open BookProof.ChapterParityChirality



open Matrix
open scoped Kronecker


open BookProof.ChapterA3
open BookProof.ChapterParity
open BookProof.ChapterParitySU2

set_option maxHeartbeats 1000000 in
theorem solution : QLProj.trace = 4 := by

  unfold QLProj;
  norm_num [ Matrix.trace_sub, chi_trace ]
