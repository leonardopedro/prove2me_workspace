-- Generated from ChapterQgFourierElimination.lean — theorem BookProof.QgFourierElim.elimTorsion_conj
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

noncomputable section

theorem BookProof.QgFourierElim.elimTorsion_conj (k : Mom) (mu nu i : Fin 3) (z : CMode) :
    (starRingEnd ℂ) (elimTorsion k mu nu i z) = elimTorsion k mu nu i z := by sorry
