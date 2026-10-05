-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.inner_sum_apply_sum
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
theorem solution (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (S T : Finset ℕ) (c e : ℕ → ℂ) :
    (inner ℂ (∑ i ∈ S, c i • b i) (H (∑ j ∈ T, e j • bvec b j)) : ℂ)
      = ∑ i ∈ S, ∑ j ∈ T, (starRingEnd ℂ) (c i) * e j * entry b H i j := by

  rw [map_sum, sum_inner]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [inner_smul_left, inner_sum, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [map_smul, inner_smul_right]
  simp only [entry]
  ring
