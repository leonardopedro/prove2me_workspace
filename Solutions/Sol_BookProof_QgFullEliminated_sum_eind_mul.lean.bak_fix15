-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.sum_eind_mul
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
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
