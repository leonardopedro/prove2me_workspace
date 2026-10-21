-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.sum_off_diag_comm
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
theorem solution (S : Finset ℕ) (G : ℕ → ℕ → ℝ) :
    ∑ i ∈ S, ∑ j ∈ S.erase i, G i j = ∑ j ∈ S, ∑ i ∈ S.erase j, G i j := by

  have h1 : ∀ i ∈ S, ∑ j ∈ S.erase i, G i j = (∑ j ∈ S, G i j) - G i i :=
    fun i hi => Finset.sum_erase_eq_sub hi
  have h2 : ∀ j ∈ S, ∑ i ∈ S.erase j, G i j = (∑ i ∈ S, G i j) - G j j :=
    fun j hj => Finset.sum_erase_eq_sub hj
  rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2, Finset.sum_sub_distrib,
    Finset.sum_sub_distrib, Finset.sum_comm]
