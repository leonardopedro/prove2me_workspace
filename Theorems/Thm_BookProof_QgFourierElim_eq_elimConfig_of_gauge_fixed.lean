-- Generated from ChapterQgFourierElimination.lean — theorem BookProof.QgFourierElim.eq_elimConfig_of_gauge_fixed
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
open BookProof.QgFourierElim



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.QgVielbeinScalaronGaugeFL

noncomputable section

theorem BookProof.QgFourierElim.eq_elimConfig_of_gauge_fixed (k : Mom) (w : Comp → ℂ)
    (h : ∀ mu nu i, formValue k (dGaugeF mu nu i) w = 0) :
    w = elimConfig k (fun p => w (eIdx p.1 p.2)) := by sorry
