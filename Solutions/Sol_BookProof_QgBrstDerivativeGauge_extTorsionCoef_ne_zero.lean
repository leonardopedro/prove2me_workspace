-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.extTorsionCoef_ne_zero
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgBrstDerivativeGauge




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in

theorem solution (k : Mom) :
    extTorsionCoef k 0 1 0 (Sum.inr (k, 0, 1, 0)) ≠ 0 := by
  simp only [extTorsionCoef]
  norm_num [Prod.ext_iff]

end
