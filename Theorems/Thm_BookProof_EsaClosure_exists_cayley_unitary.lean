-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.exists_cayley_unitary
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HashimotoShiftInvert
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]
variable [CompleteSpace F] {Dom : Submodule ℂ F}


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert


theorem BookProof.EsaClosure.exists_cayley_unitary {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u) :
    ∃ U : F ≃ₗᵢ[ℂ] F, ∀ x : Dom, U (A x + Complex.I • (x : F)) = A x - Complex.I • (x : F) := by sorry
