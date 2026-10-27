-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.essentiallySelfAdjointOn_of_intertwine
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_deficiencyTrivialAt_of_intertwine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (U : F ≃ₗᵢ[ℂ] F) (T T' : D →ₗ[ℂ] F)
    (hU : ∀ v : D, U (v : F) ∈ D)
    (hcomm : ∀ v : D, U (T v) = T' ⟨U (v : F), hU v⟩)
    (hT : EssentiallySelfAdjointOn D T) : EssentiallySelfAdjointOn D T' :=
  ⟨deficiencyTrivialAt_of_intertwine U T T' hU hcomm Complex.I hT.1,
     deficiencyTrivialAt_of_intertwine U T T' hU hcomm (-Complex.I) hT.2⟩
