-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.sum_eind_mul
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQgFourierElimination
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (d : EComp) (z : EComp → ℂ) : ∑ c : EComp, eind c d * z c = z d := by

  classical
  rw [Finset.sum_eq_single d]
  · simp [eind]
  · intro c _ hc
    simp [eind, hc]
  · intro h
    exact absurd (Finset.mem_univ d) h
