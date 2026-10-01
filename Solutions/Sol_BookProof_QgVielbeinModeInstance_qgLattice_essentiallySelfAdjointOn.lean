-- Generated from ChapterQgVielbeinModeInstance.lean — solution of BookProof.QgVielbeinModeInstance.qgLattice_essentiallySelfAdjointOn
import Mathlib
import Definitions.Def_ChapterQgVielbeinModeInstance
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_essentiallySelfAdjointOn
open BookProof.QgVielbeinModeInstance




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (sig : VMode L → ℝ)
    (hsig : ∀ a, 1 ≤ sig a) (g : ℝ) :
    EssentiallySelfAdjointOn (secN W (qgLatticeModes L sig hsig g)).dom
      (secData W (qgLatticeModes L sig hsig g)).ext := secHam_essentiallySelfAdjointOn W _
