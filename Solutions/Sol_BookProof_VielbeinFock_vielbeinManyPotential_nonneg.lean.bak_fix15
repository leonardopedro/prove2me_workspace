-- Generated from ChapterVielbeinFiberFock.lean — solution of BookProof.VielbeinFock.vielbeinManyPotential_nonneg
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
import Theorems.Thm_BookProof_VielbeinFock_shearEnergy_nonneg
import Theorems.Thm_BookProof_Starobinsky_starobinskyV_nonneg
open BookProof.VielbeinFock



open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {M alpha : ℝ} (halpha : 0 < alpha) (d : ℕ)
    (om : Fin d → ℝ) (n : ℕ) (x : vielbeinSector d n) :
    0 ≤ vielbeinManyPotential M alpha d om n x := by

  refine Finset.sum_nonneg (fun j _ => ?_)
  have h1 := shearEnergy_nonneg d om n j x
  have h2 := starobinskyV_nonneg (M := M) halpha
    (inner ℝ x (vielbeinDir d n j (Fin.last d)) : ℝ)
  linarith
