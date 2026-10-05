-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.sum_sectorPart
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_sectorPart_apply
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

variable {col : ℕ → (ℕ →₀ ℂ)} {K : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) :
    ∑ n ∈ u.support.image ndeg, sectorPart n u = u := by

  classical
  refine Finsupp.ext fun α => ?_
  rw [Finset.sum_apply']
  have hterm : ∀ n ∈ u.support.image ndeg,
      sectorPart n u α = if ndeg α = n then u α else 0 := fun n _ => sectorPart_apply n u α
  rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq]
  by_cases hu : α ∈ u.support
  · rw [if_pos (Finset.mem_image_of_mem ndeg hu)]
  · rw [Finsupp.notMem_support_iff.mp hu]
    simp
