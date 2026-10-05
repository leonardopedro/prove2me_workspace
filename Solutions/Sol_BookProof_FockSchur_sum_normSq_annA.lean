-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.sum_normSq_annA
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_ndeg_eq_sum
import Theorems.Thm_BookProof_FockSchur_normSq_annA
import Theorems.Thm_BookProof_FockSecondQuantization_support_subset_modes
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {u : FockAlg} {L : Finset ℕ} (hL : modes u ⊆ L) :
    ∑ k ∈ L, ‖toLp (annA k u)‖ ^ 2 = ∑ α ∈ u.support, (ndeg α : ℝ) * ‖u α‖ ^ 2 := by

  classical
  rw [Finset.sum_congr rfl (fun k _ => normSq_annA k u), Finset.sum_comm]
  refine Finset.sum_congr rfl fun α hα => ?_
  have hsub : α.support ⊆ L := fun i hi => hL (support_subset_modes hα hi)
  rw [← Finset.sum_mul, ndeg_eq_sum hsub]
  push_cast
  ring
