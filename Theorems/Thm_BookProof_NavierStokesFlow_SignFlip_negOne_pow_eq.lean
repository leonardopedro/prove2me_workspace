-- Generated from ChapterNavierStokesSignFlip.lean — theorem BookProof.NavierStokesFlow.SignFlip.negOne_pow_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

theorem BookProof.NavierStokesFlow.SignFlip.negOne_pow_eq (k : ℕ) : (-1 : ℂ) ^ k = 1 ∨ (-1 : ℂ) ^ k = -1 := by sorry
