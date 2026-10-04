-- Generated from ChapterQgFullEliminated.lean — theorem BookProof.QgFullEliminated.eFormValue_eq_formValue_elimConfig
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Definitions.Def_ChapterA4
open BookProof.QgFullEliminated



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa

noncomputable section

theorem BookProof.QgFullEliminated.eFormValue_eq_formValue_elimConfig (k : Mom) (F : FormIdx) (z : EComp → ℂ) :
    formValue k F (elimConfig k z) = eFormValue k F z := by sorry
