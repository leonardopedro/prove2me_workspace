-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.confNumber_confAt
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_self
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (k m : ℕ) : confNumber (confAt k m) = m := by

  classical
  rcases eq_or_ne m 0 with rfl | hm
  · simp [confAt, confNumber]
  · have hsupp : (confAt k m).support = {k} :=
      Finsupp.support_single_ne_zero k hm
    simp [confNumber, hsupp, confAt_self]
