-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.trial_quartic_form
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_confAt_injective
import Theorems.Thm_BookProof_FockCubicUnbounded_trial_support_subset
import Theorems.Thm_BookProof_FockCubicUnbounded_trial_at_n
import Theorems.Thm_BookProof_FockCubicUnbounded_trial_at_n3
import Theorems.Thm_BookProof_FockCubicUnbounded_quartA_single_confAt
import Theorems.Thm_BookProof_FockSecondQuantization_inner_toLp_of_subset
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (k n : ℕ) (c : ℝ) :
    (inner ℂ (toLp (trial k n c)) (toLp (quartA k (trial k n c))) : ℂ).re
      = (n : ℝ) * ((n : ℝ) - 1) + ((n : ℝ) + 3) * ((n : ℝ) + 2) * c ^ 2 := by

  classical
  have hne : confAt k n ≠ confAt k (n + 3) := by
    intro h
    have := confAt_injective k h
    omega
  have hq : quartA k (trial k n c)
      = Finsupp.single (confAt k n) ((((n : ℝ) * ((n : ℝ) - 1) : ℝ) : ℂ) * 1)
        + Finsupp.single (confAt k (n + 3))
            (((((n : ℝ) + 3) * (((n : ℝ) + 3) - 1) : ℝ) : ℂ) * ((c : ℝ) : ℂ)) := by
    have hn3 : (((n + 3 : ℕ) : ℝ)) = (n : ℝ) + 3 := by push_cast; ring
    rw [trial, map_add, quartA_single_confAt, quartA_single_confAt, hn3]
  have hval_n : quartA k (trial k n c) (confAt k n)
      = (((n : ℝ) * ((n : ℝ) - 1) : ℝ) : ℂ) := by
    rw [hq]
    simp [Ne.symm hne]
  have hval_n3 : quartA k (trial k n c) (confAt k (n + 3))
      = ((((n : ℝ) + 3) * ((n : ℝ) + 2) : ℝ) : ℂ) * ((c : ℝ) : ℂ) := by
    rw [hq]
    simp only [Finsupp.add_apply, Finsupp.single_apply, if_neg hne]
    push_cast
    ring
  have hinner := inner_toLp_of_subset (trial_support_subset k n c) (quartA k (trial k n c))
  have hsum : (inner ℂ (toLp (trial k n c)) (toLp (quartA k (trial k n c))) : ℂ)
      = (((n : ℝ) * ((n : ℝ) - 1) + ((n : ℝ) + 3) * ((n : ℝ) + 2) * c ^ 2 : ℝ) : ℂ) := by
    rw [hinner, Finset.sum_insert (by simpa using hne), Finset.sum_singleton,
      hval_n, hval_n3, trial_at_n, trial_at_n3]
    push_cast
    simp [Complex.conj_ofReal]
    ring
  have := congrArg Complex.re hsum
  simpa [← Complex.ofReal_pow] using this
