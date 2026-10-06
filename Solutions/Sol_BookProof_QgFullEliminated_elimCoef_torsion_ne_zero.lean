-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.elimCoef_torsion_ne_zero
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
theorem solution (k : Mom) (hk : k 0 ≠ 0) :
    elimCoef k (torsionF 0 1 0) ((1, 0) : EComp) ≠ 0 := by

  have hne : ((1, 0) : EComp) ≠ (0, 0) := by simp [Prod.ext_iff]
  have h : elimCoef k (torsionF 0 1 0) ((1, 0) : EComp) = Complex.I * ((k 0 : ℤ) : ℂ) := by
    rw [elimCoef_torsion]
    simp [eind, hne]
  rw [h]
  simp only [ne_eq, mul_eq_zero, Complex.I_ne_zero, false_or]
  exact_mod_cast hk
