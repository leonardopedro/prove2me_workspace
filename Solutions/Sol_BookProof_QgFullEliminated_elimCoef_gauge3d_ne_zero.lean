-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.elimCoef_gauge3d_ne_zero
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (hk : k 0 ≠ 0) :
    elimCoef k (gauge3dF 0) ((0, 0) : EComp) ≠ 0 := by

  have h1 : ((0, 0) : EComp) ≠ (1, 0) := by simp [Prod.ext_iff]
  have h2 : ((0, 0) : EComp) ≠ (2, 0) := by simp [Prod.ext_iff, Fin.ext_iff]
  have h : elimCoef k (gauge3dF 0) ((0, 0) : EComp) = Complex.I * ((k 0 : ℤ) : ℂ) := by
    rw [elimCoef_gauge3d, Fin.sum_univ_three]
    simp [eind, h1, h2]
  rw [h]
  simp only [ne_eq, mul_eq_zero, Complex.I_ne_zero, false_or]
  exact_mod_cast hk
