-- Generated from ChapterNavierStokesSignedShift.lean — theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.maj_shift
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

theorem BookProof.NavierStokesFlow.SignedShift.SignedHop.maj_shift : S.maj.shift = S.shift := by sorry
