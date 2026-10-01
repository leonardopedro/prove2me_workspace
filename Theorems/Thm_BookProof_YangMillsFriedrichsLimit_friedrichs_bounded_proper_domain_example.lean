-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_proper_domain_example
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
open BookProof.YangMillsFriedrichsLimit

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

m

theorem BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_proper_domain_example :
    ∃ (D : Submodule ℂ (ℓ²(ℕ, ℂ))) (A : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ)),
      Dense (D : Set (ℓ²(ℕ, ℂ))) ∧ D ≠ ⊤ ∧
      (∀ x : D, A (x : ℓ²(ℕ, ℂ)) = D.subtype x) ∧
      IsPositiveSelfAdjointExtension D.subtype (topRestrict := by sorry
