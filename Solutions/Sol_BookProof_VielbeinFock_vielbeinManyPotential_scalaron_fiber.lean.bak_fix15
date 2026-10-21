-- Generated from ChapterVielbeinFiberFock.lean — solution of BookProof.VielbeinFock.vielbeinManyPotential_scalaron_fiber
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
import Theorems.Thm_BookProof_VielbeinFock_vielbeinManyPotential_apply
open BookProof.VielbeinFock



open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (om : Fin 0 → ℝ) (n : ℕ)
    (x : vielbeinSector 0 n) :
    vielbeinManyPotential M alpha 0 om n x
      = ∑ j : Fin n, starobinskyV M alpha (x (j, Fin.last 0)) := by

  simp [vielbeinManyPotential_apply]
