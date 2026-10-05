-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.eq_absRel_of_isNonnegSelfAdjoint
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_rel_eq_of_invCLM_eq
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_cfc
import Theorems.Thm_BookProof_PositiveSquareRoot_isNonnegSelfAdjoint_absRel
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) (hT : IsNonnegSelfAdjoint T)
    (hsq : ∀ p : F × F, (∃ w, (p.1, w) ∈ T ∧ (w, p.2) ∈ T) → p ∈ factorRel A) :
    T = absRel A := by

  have habs : ∀ p : F × F,
      (∃ w, (p.1, w) ∈ absRel A ∧ (w, p.2) ∈ absRel A) → p ∈ factorRel A := by
    intro p hp
    have hmem : p ∈ {q : F × F | ∃ w, (q.1, w) ∈ absRel A ∧ (w, q.2) ∈ absRel A} := hp
    rw [absRel_comp_self A] at hmem
    exact hmem
  exact rel_eq_of_invCLM_eq hT (isNonnegSelfAdjoint_absRel A)
    ((invCLM_eq_cfc A hT hsq).trans (invCLM_eq_cfc A (isNonnegSelfAdjoint_absRel A) habs).symm)
