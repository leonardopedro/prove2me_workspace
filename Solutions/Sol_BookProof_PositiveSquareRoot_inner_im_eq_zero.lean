-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.inner_im_eq_zero
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_symm_inner
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) {p : F × F} (hp : p ∈ T) :
    (inner ℂ p.1 p.2 : ℂ).im = 0 := by

  have h := symm_inner hT hp hp
  have h2 : (starRingEnd ℂ) (inner ℂ p.1 p.2 : ℂ) = inner ℂ p.1 p.2 := by
    rw [inner_conj_symm]; exact h
  exact Complex.conj_eq_iff_im.1 h2
