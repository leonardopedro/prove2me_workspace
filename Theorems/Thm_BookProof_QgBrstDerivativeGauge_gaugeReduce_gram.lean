-- Generated from ChapterQgBrstDerivativeGauge.lean — theorem BookProof.QgBrstDerivativeGauge.gaugeReduce_gram
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge
open BookProof.QgBrstDerivativeGauge



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgBrstDerivativeGauge.gaugeReduce_gram (x y : CMode) (h : x.1 = y.1) :
    ∑ mu : Fin 3, ∑ nu : Fin 3, ∑ i : Fin 3,
        (starRingEnd ℂ) (gaugeReduce (extTorsionCoef x.1 mu nu i) x)
          * gaugeReduce (extTorsionCoef x.1 mu nu i) y
      = contTorsionGram x y := by sorry
