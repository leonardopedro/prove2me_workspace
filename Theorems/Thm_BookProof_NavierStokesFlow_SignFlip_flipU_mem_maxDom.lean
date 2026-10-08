-- Generated from ChapterNavierStokesSignFlip.lean — theorem BookProof.NavierStokesFlow.SignFlip.flipU_mem_maxDom
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip


open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

theorem BookProof.NavierStokesFlow.SignFlip.flipU_mem_maxDom (p : ι → ℕ) (s : ι → ℝ) {x : L2I ι} (hx : x ∈ maxDom s) :
    flipU p x ∈ maxDom s := by sorry
