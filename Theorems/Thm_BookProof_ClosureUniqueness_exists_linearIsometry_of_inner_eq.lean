-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.exists_linearIsometry_of_inner_eq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.exists_linearIsometry_of_inner_eq (B C : D →ₗ[ℂ] F)
    (h : ∀ x y : D, (inner ℂ (B x) (B y) : ℂ) = inner ℂ (C x) (C y)) :
    ∃ U : LinearMap.range B →ₗ[ℂ] F,
      (∀ x : D, U ⟨B x, LinearMap.mem_range_self B x⟩ = C x) ∧
      (∀ z : LinearMap.range B, ‖U z‖ = ‖(z : F)‖) ∧
      LinearMap.range U = LinearMap.range C := by sorry
