-- Generated from ChapterVielbeinFiberFock.lean — solution of BookProof.VielbeinFock.inner_vielbeinDir
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
open BookProof.VielbeinFock



open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (d n : ℕ) (x : vielbeinSector d n) (j : Fin n) (i : Fin (d + 1)) :
    (inner ℝ x (vielbeinDir d n j i) : ℝ) = x (j, i) := by

  rw [vielbeinDir, EuclideanSpace.inner_single_right]
  simp
