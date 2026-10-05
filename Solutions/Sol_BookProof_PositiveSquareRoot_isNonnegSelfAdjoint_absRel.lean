-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.isNonnegSelfAdjoint_absRel
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
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
theorem solution (A : D →ₗ[ℂ] F) : IsNonnegSelfAdjoint (absRel A) where
  adj :=
  where
    adj := adjPairs_absRel A
    nonneg := by
      intro p hp
      have h := absRel_quadForm_nonneg A hp
      have hre : 0 ≤ (inner ℂ p.2 p.1 : ℂ).re := by
        have := Complex.le_def.1 h
        simpa using this.1
      have hconj : (inner ℂ p.2 p.1 : ℂ) = (starRingEnd ℂ) (inner ℂ p.1 p.2 : ℂ) :=
        (inner_conj_symm _ _).symm
      rwa [hconj, Complex.conj_re] at hre
