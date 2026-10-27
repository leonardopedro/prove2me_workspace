-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.two_mul_sqrt_le
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution {c n N t : ℝ} (hN : 0 ≤ N) (ht : 0 < t) :
    2 * c * Real.sqrt N * n ≤ t * N + c ^ 2 / t * n ^ 2 := by

  have key : ∀ s : ℝ, 2 * c * s * n ≤ t * s ^ 2 + c ^ 2 / t * n ^ 2 := by
    intro s
    rw [← sub_nonneg]
    have hid : t * s ^ 2 + c ^ 2 / t * n ^ 2 - 2 * c * s * n
        = (t * s - c * n) ^ 2 / t := by
      field_simp
      ring
    rw [hid]
    positivity
  have h := key (Real.sqrt N)
  rwa [Real.sq_sqrt hN] at h
