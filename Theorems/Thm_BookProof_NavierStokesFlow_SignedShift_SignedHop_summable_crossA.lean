-- Generated from ChapterNavierStokesSignedShift.lean — theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.summable_crossA
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

theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.summable_crossA {X Y : ι → ℂ}
    (hX : Summable fun β => (S.maj.ampSeq X β) ^ 2) (hY : Summable fun β => ‖Y β‖ ^ 2) :
    Summable (S.crossA X Y) := by sorry
