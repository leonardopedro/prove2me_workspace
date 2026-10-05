-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.elimTorsion_eq_gaugeReduce
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Theorems.Thm_BookProof_QgFourierElim_elimTorsion_eq_torsionCoef
import Theorems.Thm_BookProof_QgBrstDerivativeGauge_gaugeReduce_extTorsionCoef
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (mu nu i : Fin 3) (x : CMode) :
    elimTorsion k mu nu i x = gaugeReduce (extTorsionCoef k mu nu i) x := by

  rw [elimTorsion_eq_torsionCoef, gaugeReduce_extTorsionCoef]
