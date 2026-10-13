-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.elimTorsion_eq_torsionCoef
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.QgVielbeinScalaronGaugeFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (mu nu i : Fin 3) (z : CMode) :
    elimTorsion k mu nu i z = if z.1 = k then torsionCoef k mu nu i z else 0 := by

  by_cases hk : z.1 = k
  · simp only [elimTorsion, elimD, torsionCoef, if_pos hk]
  · simp only [elimTorsion, elimD, if_neg hk, sub_zero]
