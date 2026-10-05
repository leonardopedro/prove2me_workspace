-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.norm_sq_sum
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
open BookProof.SchurGershgorin



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (S : Finset ℕ) (c : ℕ → ℂ) :
    ‖∑ i ∈ S, c i • b i‖ ^ 2 = ∑ i ∈ S, ‖c i‖ ^ 2 := by

  have h := congrArg Complex.re (b.orthonormal.inner_sum c c S)
  have hl : (inner ℂ (∑ i ∈ S, c i • b i) (∑ i ∈ S, c i • b i) : ℂ).re
      = ‖∑ i ∈ S, c i • b i‖ ^ 2 := by
    rw [inner_self_eq_norm_sq_to_K (𝕜 := ℂ)]
    norm_cast
  have hr : (∑ i ∈ S, (starRingEnd ℂ) (c i) * c i).re = ∑ i ∈ S, ‖c i‖ ^ 2 := by
    simp [Complex.re_sum, ← Complex.normSq_eq_conj_mul_self, Complex.normSq_eq_norm_sq,
      -Complex.ofReal_pow]
  rw [hl, hr] at h
  exact h
