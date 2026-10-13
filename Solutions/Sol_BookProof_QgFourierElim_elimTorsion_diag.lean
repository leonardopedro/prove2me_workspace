-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.elimTorsion_diag
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
theorem solution (k : Mom) (mu i : Fin 3) (z : CMode) :
    elimTorsion k mu mu i z = 0 := by

  simp only [elimTorsion, sub_self]
