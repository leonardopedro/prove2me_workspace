-- Generated from ChapterQgVielbeinModeInstance.lean — theorem BookProof.QgVielbeinModeInstance.qgLattice_ext_core
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

theorem BookProof.QgVielbeinModeInstance.qgLattice_ext_core (W : WallPot) (sig : VMode L → ℝ) (hsig : ∀ a, 1 ≤ sig a) (g : ℝ)
    (p : secCore (ι := VMode L)) :
    (secData W (qgLatticeModes L sig hsig g)).ext
        ⟨(p : Sec (VMode L)), (secData W (qgLatticeModes L sig hsig g)).gc.le p.2⟩
      = secHam W (qgLatticeModes L sig hsig g) p := by sorry
