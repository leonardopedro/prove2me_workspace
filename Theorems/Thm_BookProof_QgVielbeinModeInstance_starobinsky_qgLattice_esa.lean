-- Generated from ChapterQgVielbeinModeInstance.lean — theorem BookProof.QgVielbeinModeInstance.starobinsky_qgLattice_esa
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

variable {ι : Type*}
variable [Fintype ι] [DecidableEq ι]
variable (L : ℕ) [NeZero L]



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section


theorem BookProof.QgVielbeinModeInstance.starobinsky_qgLattice_esa (M alpha : ℝ) (halpha : 0 < alpha) (sig : VMode L → ℝ)
    (hsig : ∀ a, 1 ≤ sig a) (g : ℝ) :
    EssentiallySelfAdjointOn
        (secN (starobinskyWall M alpha halpha) (qgLatticeModes L sig hsig g)).dom
      (secData (starobinskyWall M alpha halpha) (qgLatticeModes L sig hsig g)).ext := by sorry
