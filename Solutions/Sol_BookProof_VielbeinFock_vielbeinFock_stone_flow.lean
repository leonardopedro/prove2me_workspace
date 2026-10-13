-- Generated from ChapterVielbeinFiberFock.lean — solution of BookProof.VielbeinFock.vielbeinFock_stone_flow
import Mathlib
import Definitions.Def_ChapterVielbeinFiberFock
import Theorems.Thm_BookProof_ScalaronFock_fockSmoothPotential_stone_flow
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronFockEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.VielbeinFock



open Filter Topology MeasureTheory


open BookProof.Starobinsky BookProof.ScalaronEsa BookProof.ScalaronFock
open BookProof.DirectSumEsa BookProof.StoneBridge BookProof.EsaClosure
open BookProof.FarisLavine BookProof.ChapterStoneResolvent
open BookProof.EsaClosure
open BookProof.StoneBridge

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (d : ℕ) (om : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (vielbeinFock d))
      (U : ℝ → (vielbeinFock d →L[ℂ] vielbeinFock d)),
      IsSelfAdjointExtension (vielbeinFockHamiltonian M alpha d om) T.op ∧ IsStoneFlow T U :=
  fockSmoothPotential_stone_flow (E := vielbeinSector d)
      (fun n => vielbeinManyPotential M alpha d om n)
      (fun n => contDiff_vielbeinManyPotential M alpha d om n)
