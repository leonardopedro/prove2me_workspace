-- Generated from ChapterQgVielbeinModeInstance.lean — theorem BookProof.QgVielbeinModeInstance.qgLattice_essentiallySelfAdjointOn
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.QgVielbeinModeInstance



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

variable {ι : Type*}

variable [Fintype ι] [DecidableEq ι]
variable (L : ℕ) [NeZero L]

theorem BookProof.QgVielbeinModeInstance.qgLattice_essentiallySelfAdjointOn (W : WallPot) (sig : VMode L → ℝ)
    (hsig : ∀ a, 1 ≤ sig a) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgLatticeModes L sig hsig g)).dom
      (secData W (qgLatticeModes L sig hsig g)).ext := by sorry
