-- Generated from ChapterQgFourierElimination.lean — theorem BookProof.QgFourierElim.elimTorsion_eq_gaugeReduce
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Definitions.Def_ChapterA4
open BookProof.QgFourierElim



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgFourierElim.elimTorsion_eq_gaugeReduce (k : Mom) (mu nu i : Fin 3) (x : CMode) :
    elimTorsion k mu nu i x = gaugeReduce (extTorsionCoef k mu nu i) x := by sorry
