-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.extTorsionCoef_ne_zero
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge




open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) :
    extTorsionCoef k 0 1 0 (Sum.inr (k, 0, 1, 0)) ≠ 0 := by

  simp only [extTorsionCoef]
  norm_num [Prod.ext_iff]
