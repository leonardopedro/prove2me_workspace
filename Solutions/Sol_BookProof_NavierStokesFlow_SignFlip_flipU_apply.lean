-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.flipU_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (p : ι → ℕ) (x : L2I ι) : flipU p x = flipMap p x := rfl
