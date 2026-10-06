-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.inner_trial_other
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution : (inner ℂ trial other : ℂ) = 0 := by

  simp [trial, other, EuclideanSpace.inner_single_left, EuclideanSpace.single_apply]
