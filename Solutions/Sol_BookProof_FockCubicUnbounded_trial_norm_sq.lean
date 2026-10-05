-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.trial_norm_sq
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_injective
import Theorems.Thm_BookProof_FockCubicUnbounded_trial_support_subset
import Theorems.Thm_BookProof_FockCubicUnbounded_trial_at_n
import Theorems.Thm_BookProof_FockCubicUnbounded_trial_at_n3
import Theorems.Thm_BookProof_FockSecondQuantization_inner_toLp_of_subset
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (k n : ℕ) (c : ℝ) : ‖toLp (trial k n c)‖ ^ 2 = 1 + c ^ 2 := by

  classical
  have hne : confAt k n ≠ confAt k (n + 3) := by
    intro h
    have := confAt_injective k h
    omega
  have hinner := inner_toLp_of_subset (trial_support_subset k n c) (trial k n c)
  have hsum : (inner ℂ (toLp (trial k n c)) (toLp (trial k n c)) : ℂ)
      = ((1 + c ^ 2 : ℝ) : ℂ) := by
    rw [hinner, Finset.sum_insert (by simpa using hne), Finset.sum_singleton,
      trial_at_n, trial_at_n3]
    push_cast
    simp [Complex.conj_ofReal]
    ring
  have := congrArg Complex.re hsum
  rw [inner_self_eq_norm_sq_to_K] at this
  simpa [← Complex.ofReal_pow] using this
