-- Generated from ChapterBell.lean — solution of BookProof.ChapterBell.chsh_quantum_violates_local_bound
import Mathlib
import Definitions.Def_ChapterBell
open BookProof.ChapterBell



open scoped BigOperators
open MeasureTheory

variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
theorem solution : (2 : ℝ) < 2 * Real.sqrt 2 := by

  nlinarith [Real.sqrt_nonneg 2, Real.sq_sqrt zero_le_two]
