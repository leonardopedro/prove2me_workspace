-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.farisLavine_closure_isSelfAdjoint_unique
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

variable [CompleteSpace F]

theorem BookProof.ClosureUniqueness.farisLavine_closure_isSelfAdjoint_unique (H N : D →ₗ[ℂ] F) (c : ℝ)
    (hdense : Dense (D : Set F)) (hH : SymmetricOn D H) (hN : SymmetricOn D N) (hc : 0 ≤ c)
    (hNpos : ∀ x : D, 0 ≤ quadForm N x)
    (hNsurj : ∀ f : F, ∃ x : D, N x + (x : F) = f)
    (hcomm : ∀ x : D, |commForm H N x| ≤ c * quadForm N x) :
    IsClosureOf H (clExt H hdense hH) ∧ IsSelfAdjointExtension H (clExt H hdense hH) ∧
      ∀ {Dom : Submodule ℂ F} (A : Dom →ₗ[ℂ] F), IsSelfAdjointExtension H A →
        Dom = clDom H ∧ ∀ (x : F) (h : x ∈ Dom) (h' : x ∈ clDom H),
          A ⟨x, h⟩ = clExt H hdense hH ⟨x, h'⟩ := by sorry
