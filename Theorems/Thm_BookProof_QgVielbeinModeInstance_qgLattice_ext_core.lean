-- Generated from ChapterQgVielbeinModeInstance.lean — theorem BookProof.QgVielbeinModeInstance.qgLattice_ext_core
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData

variable {ι : Type*}
variable [Fintype ι] [DecidableEq ι]
variable (L : ℕ) [NeZero L]



open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section


theorem BookProof.QgVielbeinModeInstance.qgLattice_ext_core (W : WallPot) (sig : VMode L → ℝ) (hsig : ∀ a, 1 ≤ sig a) (g : ℝ)
    (p : secCore (ι := by sorry
