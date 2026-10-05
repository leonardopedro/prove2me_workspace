-- Generated from ChapterQgVielbeinModeInstance.lean — solution of BookProof.QgVielbeinModeInstance.starobinsky_qgLattice_esa
import Mathlib
import Definitions.Def_ChapterQgVielbeinModeInstance
import Theorems.Thm_BookProof_QgVielbeinModeInstance_qgLattice_essentiallySelfAdjointOn
open BookProof.QgVielbeinModeInstance




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable [Fintype ι] [DecidableEq ι]
variable (L : ℕ) [NeZero L]

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (halpha : 0 < alpha) (sig : VMode L → ℝ)
    (hsig : ∀ a, 1 ≤ sig a) (g : ℝ) :
    EssentiallySelfAdjointOn
        (secN (starobinskyWall M alpha halpha) (qgLatticeModes L sig hsig g)).dom
      (secData (starobinskyWall M alpha halpha) (qgLatticeModes L sig hsig g)).ext := qgLattice_essentiallySelfAdjointOn L (starobinskyWall M alpha halpha) sig hsig g
