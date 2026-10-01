-- Generated from ChapterNavierStokesSignedShift.lean — theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.norm_crossB_le
import Mathlib
import Definitions.Def_ChapterNavierStokesSignedShift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignedShift.SignedHop

variable {ι : Type*}
variable {sym : ι → ℝ} (S : SignedHop ι sym)
variable {sym : ι → ℝ}
variable (kap cst : ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ShiftHamiltonian AffineFiber

variable {ι : Type*}

theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.norm_crossB_le (X Y : ι → ℂ) (β : ι) :
    ‖S.crossB X Y β‖ ≤ S.maj.ampSeq X (S.shift β) * ‖Y β‖ := by sorry
