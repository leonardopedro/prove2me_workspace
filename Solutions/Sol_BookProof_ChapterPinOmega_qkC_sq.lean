-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.qkC_sq
import Mathlib
import Definitions.Def_ChapterPinOmega
import Theorems.Thm_BookProof_ChapterPinOmega_qk_sq
import Theorems.Thm_BookProof_ChapterPinOmega_qkC_eq_cast
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : qkC * qkC = -1 := by

  rw [qkC_eq_cast, ← map_mul, qk_sq, map_neg, map_one]
