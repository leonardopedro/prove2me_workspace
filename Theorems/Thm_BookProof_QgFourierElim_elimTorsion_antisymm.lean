-- Generated from ChapterQgFourierElimination.lean — theorem BookProof.QgFourierElim.elimTorsion_antisymm
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

theorem BookProof.QgFourierElim.elimTorsion_antisymm (k : Mom) (mu nu i : Fin 3) (z : CMode) :
    elimTorsion k nu mu i z = -elimTorsion k mu nu i z := by sorry
