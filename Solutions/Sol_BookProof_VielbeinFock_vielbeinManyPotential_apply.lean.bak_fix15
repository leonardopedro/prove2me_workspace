-- Generated from ChapterVielbeinFiberFock.lean — solution of BookProof.VielbeinFock.vielbeinManyPotential_apply
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
import Theorems.Thm_BookProof_VielbeinFock_inner_vielbeinDir
import Theorems.Thm_BookProof_VielbeinFock_shearEnergy_apply
open BookProof.VielbeinFock



open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) (n : ℕ)
    (x : vielbeinSector d n) :
    vielbeinManyPotential M alpha d om n x
      = ∑ j : Fin n, ((∑ i : Fin d, om i ^ 2 / 2 * (x (j, i.castSucc)) ^ 2)
        + starobinskyV M alpha (x (j, Fin.last d))) := by

  refine Finset.sum_congr rfl (fun j _ => ?_)
  rw [shearEnergy_apply, inner_vielbeinDir]
