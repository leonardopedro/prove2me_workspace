-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.qjC_sq
import Mathlib
import Definitions.Def_ChapterPinOmega
import Theorems.Thm_BookProof_ChapterPinOmega_qj_sq
import Theorems.Thm_BookProof_ChapterPinOmega_qjC_eq_cast
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : qjC * qjC = -1 := by

  rw [qjC_eq_cast, ← map_mul, qj_sq, map_neg, map_one]
