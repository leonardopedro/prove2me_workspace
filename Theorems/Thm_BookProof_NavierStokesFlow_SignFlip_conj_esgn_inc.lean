-- Generated from ChapterNavierStokesSignFlip.lean — theorem BookProof.NavierStokesFlow.SignFlip.conj_esgn_inc
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

theorem BookProof.NavierStokesFlow.SignFlip.conj_esgn_inc (c : ℝ) : (starRingEnd ℂ) (esgn c) = esgn c := by sorry
