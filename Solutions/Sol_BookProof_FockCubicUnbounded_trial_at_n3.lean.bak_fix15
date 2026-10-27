-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.trial_at_n3
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_injective
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (k n : ℕ) (c : ℝ) :
    trial k n c (confAt k (n + 3)) = ((c : ℝ) : ℂ) := by

  have hne : confAt k n ≠ confAt k (n + 3) := by
    intro h
    have := confAt_injective k h
    omega
  simp [trial, hne]
