-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.up_confAt
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockSecondQuantization_up_of_ne
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (k m : ℕ) : up k (confAt k m) = confAt k (m + 1) := by

  refine Finsupp.ext fun i => ?_
  rcases eq_or_ne i k with rfl | h
  · simp [up, confAt]
  · rw [up_of_ne _ h]
    simp [confAt, h]
