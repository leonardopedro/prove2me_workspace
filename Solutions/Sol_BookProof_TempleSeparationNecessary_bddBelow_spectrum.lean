-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.bddBelow_spectrum
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution (A : E2 →L[ℂ] E2) : BddBelow (spectrum ℝ A) := by

  refine ⟨-‖A‖, fun t ht => ?_⟩
  have h := spectrum.norm_le_norm_of_mem ht
  have : |t| ≤ ‖A‖ := by simpa [Real.norm_eq_abs] using h
  cases abs_le.mp this with
  | intro h1 _ => exact h1
