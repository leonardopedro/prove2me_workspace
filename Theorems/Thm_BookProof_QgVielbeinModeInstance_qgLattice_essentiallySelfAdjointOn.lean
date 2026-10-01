-- Generated from ChapterQgVielbeinModeInstance.lean — theorem BookProof.QgVielbeinModeInstance.qgLattice_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgVielbeinModeInstance
open BookProof.QgVielbeinModeInstance

variable {ι : Type*}
variable [Fintype ι] [DecidableEq ι]
variable (L : ℕ) [NeZero L]



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

variable {ι : Type*}

theorem BookProof.QgVielbeinModeInstance.qgLattice_essentiallySelfAdjointOn (W : WallPot) (sig : VMode L → ℝ)
    (hsig : ∀ a, 1 ≤ sig a) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgLatticeModes L sig hsig g)).dom
      (secData W (qgLatticeModes L sig hsig g)).ext := by sorry
