-- Generated from ChapterQgBrstDerivativeGauge.lean — theorem BookProof.QgBrstDerivativeGauge.gaugeReduce_extTorsionCoef
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
open BookProof.QgBrstDerivativeGauge



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgBrstDerivativeGauge.gaugeReduce_extTorsionCoef (k : Mom) (mu nu i : Fin 3) (x : CMode) :
    gaugeReduce (extTorsionCoef k mu nu i) x
      = if x.1 = k then torsionCoef k mu nu i x else 0 := by sorry
