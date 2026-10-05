-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.annVec_creVec
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_annA_creA
import Theorems.Thm_BookProof_FockFieldPerturbation_annVec_apply
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (g : ℕ →₀ ℂ) (u : FockAlg) :
    annVec g (creVec g u) = creVec g (annVec g u) + ((l2sq g : ℝ) : ℂ) • u := by

  classical
  have hL : annVec g (creVec g u)
      = ∑ i ∈ g.support, ∑ j ∈ g.support,
          (((starRingEnd ℂ) (g i)) * g j)
            • (creA j (annA i u) + (if i = j then u else (0 : FockAlg))) := by
    rw [annVec_apply]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [creVec_apply, map_sum, Finset.smul_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, smul_smul, annA_creA]
  have hR : creVec g (annVec g u)
      = ∑ i ∈ g.support, ∑ j ∈ g.support,
          (((starRingEnd ℂ) (g i)) * g j) • creA j (annA i u) := by
    rw [creVec_apply, Finset.sum_comm]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [annVec_apply, map_sum, Finset.smul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [map_smul, smul_smul, mul_comm]
  have hdiag : ∑ i ∈ g.support, ∑ j ∈ g.support,
      (((starRingEnd ℂ) (g i)) * g j) • (if i = j then u else (0 : FockAlg))
        = ((l2sq g : ℝ) : ℂ) • u := by
    have hterm : ∀ i ∈ g.support, ∑ j ∈ g.support,
        (((starRingEnd ℂ) (g i)) * g j) • (if i = j then u else (0 : FockAlg))
          = ((‖g i‖ ^ 2 : ℝ) : ℂ) • u := by
      intro i hi
      rw [Finset.sum_eq_single i]
      · rw [if_pos rfl, RCLike.conj_mul]
        norm_cast
      · intro j _ hj
        rw [if_neg (fun h : i = j => hj h.symm), smul_zero]
      · intro hi'; exact absurd hi hi'
    rw [Finset.sum_congr rfl hterm, ← Finset.sum_smul, l2sq]
    norm_cast
  calc annVec g (creVec g u)
      = ∑ i ∈ g.support, ∑ j ∈ g.support,
          ((((starRingEnd ℂ) (g i)) * g j) • creA j (annA i u)
            + (((starRingEnd ℂ) (g i)) * g j) • (if i = j then u else (0 : FockAlg))) := by
        rw [hL]
        exact Finset.sum_congr rfl fun i _ =>
          Finset.sum_congr rfl fun j _ => smul_add _ _ _
    _ = creVec g (annVec g u) + ((l2sq g : ℝ) : ℂ) • u := by
        rw [← hdiag, hR, ← Finset.sum_add_distrib]
        exact Finset.sum_congr rfl fun i _ => Finset.sum_add_distrib
