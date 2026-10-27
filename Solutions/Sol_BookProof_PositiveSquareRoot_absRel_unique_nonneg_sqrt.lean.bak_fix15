-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.absRel_unique_nonneg_sqrt
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_isNonnegSelfAdjoint_absRel
import Theorems.Thm_BookProof_PositiveSquareRoot_eq_absRel_of_isNonnegSelfAdjoint
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (A : D →ₗ[ℂ] F) :
    IsNonnegSelfAdjoint (absRel A) ∧
      {p : F × F | ∃ w, (p.1, w) ∈ absRel A ∧ (w, p.2) ∈ absRel A}
        = (factorRel A : Set (F × F)) ∧
      ∀ T : Submodule ℂ (F × F), IsNonnegSelfAdjoint T →
        {p : F × F | ∃ w, (p.1, w) ∈ T ∧ (w, p.2) ∈ T} = (factorRel A : Set (F × F)) →
        T = absRel A := by

  refine ⟨isNonnegSelfAdjoint_absRel A, absRel_comp_self A, fun S hS hsq => ?_⟩
  refine eq_absRel_of_isNonnegSelfAdjoint A hS fun p hp => ?_
  have hmem : p ∈ {q : F × F | ∃ w, (q.1, w) ∈ S ∧ (w, q.2) ∈ S} := hp
  rw [hsq] at hmem
  exact hmem
