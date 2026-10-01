-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.condProb_of_continuity_infinite
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite

variable {X : Type*}


open scoped ENNReal InnerProductSpace

nPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ) :
    bornPMF v t psi hpsi z
      = ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) := rfl

theorem BookProof.ChapterContinuityUnitaryInfinite.condProb_of_continuity_infinite (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hp := by sorry
