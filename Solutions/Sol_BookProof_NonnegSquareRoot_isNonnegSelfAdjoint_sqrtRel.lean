-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.isNonnegSelfAdjoint_sqrtRel
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_adjPairs_sqrtRel
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtRel_quadForm_nonneg
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) :
    IsNonnegSelfAdjoint (sqrtRel hT) where
  adj :=
  where
    adj := adjPairs_sqrtRel hT
    nonneg := by
      intro p hp
      have h := sqrtRel_quadForm_nonneg hT hp
      have hre : 0 ≤ (inner ℂ p.2 p.1 : ℂ).re := by
        have := Complex.le_def.1 h
        simpa using this.1
      have hconj : (inner ℂ p.2 p.1 : ℂ) = (starRingEnd ℂ) (inner ℂ p.1 p.2 : ℂ) :=
        (inner_conj_symm _ _).symm
      rwa [hconj, Complex.conj_re] at hre
