-- Generated from ChapterVielbeinFiberFock.lean — solution of BookProof.VielbeinFock.shearEnergy_apply
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
import Theorems.Thm_BookProof_VielbeinFock_inner_vielbeinDir
open BookProof.VielbeinFock



open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (om : Fin d → ℝ) (n : ℕ) (j : Fin n)
    (x : vielbeinSector d n) :
    shearEnergy d om n j x = ∑ i : Fin d, om i ^ 2 / 2 * (x (j, i.castSucc)) ^ 2 := by

  refine Finset.sum_congr rfl (fun i _ => ?_)
  rw [inner_vielbeinDir]
