-- Generated from ChapterTempleSeparationNecessary.lean — solution of BookProof.TempleSeparationNecessary.other_ne_zero
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
open BookProof.TempleSeparationNecessary



noncomputable section


open BookProof.RitzCertificate

set_option maxHeartbeats 1000000 in
theorem solution : other ≠ 0 := by

  intro h
  have := congrArg (fun v : E2 => v 1) h
  simp [other, EuclideanSpace.single_apply] at this
