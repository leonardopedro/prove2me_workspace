-- Generated from ChapterPinOmega.lean — solution of BookProof.ChapterPinOmega.qjC_eq_cast
import Mathlib
import Definitions.Def_ChapterPinOmega
open BookProof.ChapterPinOmega



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : qjC = (Int.castRingHom ℂ).mapMatrix qj := by

  rw [qjC, qj, map_neg, map_mul]; rfl
