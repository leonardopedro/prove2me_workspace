-- Generated from ChapterParityHypercharge.lean — solution of BookProof.ChapterParityHypercharge.mgamma5_real
import Mathlib
import Definitions.Def_ChapterParityHypercharge
open BookProof.ChapterParityHypercharge



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : (mgamma5).map (starRingEnd ℂ) = mgamma5 := by

  ext i j; simp [mgamma5]
