-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.exists_selfAdjointExtension_and_cayley_of_esa
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_exists_isSelfAdjointExtension_of_esa
import Theorems.Thm_BookProof_EsaClosure_exists_cayley_unitary
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]
variable [CompleteSpace F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
 F))) = _
  rw [hx]
  exact hmx x

theorem solution (T : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (hesa : EssentiallySelfAdjointOn D T) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (U : F ≃ₗᵢ[ℂ] F),
      IsSelfAdjointExtension T A ∧
      ∀ x : Dom, U (A x + Complex.I • (x : :=
   F)) = A x - Complex.I • (x : F) := by
    obtain ⟨Dom, A, hA⟩ := exists_isSelfAdjointExtension_of_esa T hdense hsym hesa
    obtain ⟨hext, hsymA, hsa⟩ := hA
    obtain ⟨U, hU⟩ := exists_cayley_unitary hsymA hsa
    exact ⟨Dom,
