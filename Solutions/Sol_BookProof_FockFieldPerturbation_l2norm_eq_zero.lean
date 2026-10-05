-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.l2norm_eq_zero
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution {f : ℕ →₀ ℂ} (h : l2norm f = 0) : f = 0 := by

  classical
  have hsum : ∑ j ∈ f.support, ‖f j‖ ^ 2 = 0 := by
    have hnn : 0 ≤ ∑ j ∈ f.support, ‖f j‖ ^ 2 :=
      Finset.sum_nonneg fun j _ => sq_nonneg _
    exact (Real.sqrt_eq_zero hnn).mp h
  refine Finsupp.ext fun j => ?_
  by_cases hj : j ∈ f.support
  · have hzero : ‖f j‖ ^ 2 = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => sq_nonneg _)).mp hsum j hj
    have : ‖f j‖ = 0 := by nlinarith [norm_nonneg (f j)]
    simpa using this
  · simpa using Finsupp.notMem_support_iff.mp hj
