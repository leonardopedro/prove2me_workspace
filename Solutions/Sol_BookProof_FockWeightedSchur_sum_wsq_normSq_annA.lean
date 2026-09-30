-- Generated from ChapterFockWeightedSchurEsa.lean — solution of BookProof.FockWeightedSchur.sum_wsq_normSq_annA
import Mathlib
import Definitions.Def_ChapterFockWeightedSchurEsa
import Theorems.Thm_BookProof_FockWeightedSchur_wdeg_eq_sum
open BookProof.FockWeightedSchur














open BookProof.FockSecondQuantization BookProof.CoreBounds BookProof.FockSchur
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section




variable {w : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {u : FockAlg} {L : Finset ℕ} (hL : modes u ⊆ L) :
    ∑ k ∈ L, w k ^ 2 * ‖toLp (annA k u)‖ ^ 2 = ∑ α ∈ u.support, wdeg w α * ‖u α‖ ^ 2 := by

  classical
  rw [Finset.sum_congr rfl (fun k _ => by rw [normSq_annA k u, Finset.mul_sum]),
    Finset.sum_comm]
  refine Finset.sum_congr rfl fun α hα => ?_
  have hsub : α.support ⊆ L := fun i hi => hL (support_subset_modes hα hi)
  rw [wdeg_eq_sum hsub, Finset.sum_mul]
  exact Finset.sum_congr rfl fun k _ => by ring
