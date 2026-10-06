-- Generated from ChapterAngularMomentum.lean — solution of BookProof.ChapterAngularMomentum.circHarm_abs
import Mathlib
import Definitions.Def_ChapterAngularMomentum
open BookProof.ChapterAngularMomentum




open Complex

set_option maxHeartbeats 1000000 in
theorem solution {μ : ℕ} {z : ℂ} (hz : z ≠ 0) : ‖circHarm μ z‖ = 1 := by

  have hnz : ‖z‖ ≠ 0 := norm_ne_zero_iff.mpr hz
  rw [circHarm, norm_pow, norm_div]
  simp [hnz]
