-- Generated from ChapterVielbeinFiberFock.lean — solution of BookProof.VielbeinFock.shearEnergy_nonneg
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronFockEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.VielbeinFock



open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) (om : Fin d → ℝ) (n : ℕ) (j : Fin n)
    (x : vielbeinSector d n) : 0 ≤ shearEnergy d om n j x := Finset.sum_nonneg (fun i _ => by positivity)
