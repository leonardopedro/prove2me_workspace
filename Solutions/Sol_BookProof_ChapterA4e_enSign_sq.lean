-- Generated from ChapterA4e.lean — solution of BookProof.ChapterA4e.enSign_sq
import Mathlib
import Definitions.Def_ChapterA4e
open BookProof.ChapterA4e



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution : enSign * enSign = -1 := by

  rw [enSign, ← map_mul, coeffMass1Z_sq, map_neg, map_one]
