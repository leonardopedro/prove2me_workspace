-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.trial_at_n
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_injective
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterTempleSeparationNecessary
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockSecondQuantization
open BookProof.TempleSeparationNecessary

set_option maxHeartbeats 1000000 in
theorem solution (k n : ℕ) (c : ℝ) : trial k n c (confAt k n) = 1 := by

  have hne : confAt k (n + 3) ≠ confAt k n := by
    intro h
    have := confAt_injective k h
    omega
  simp [trial, hne]
