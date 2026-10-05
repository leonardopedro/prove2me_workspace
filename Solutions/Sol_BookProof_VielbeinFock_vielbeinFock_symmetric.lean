-- Generated from ChapterVielbeinFiberFock.lean — solution of BookProof.VielbeinFock.vielbeinFock_symmetric
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
import Theorems.Thm_BookProof_ScalaronFock_fockSmoothPotential_symmetric
open BookProof.VielbeinFock



open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) :
    SymmetricOn (vielbeinFockCore d) (vielbeinFockHamiltonian M alpha d om) := fockSmoothPotential_symmetric _ _
