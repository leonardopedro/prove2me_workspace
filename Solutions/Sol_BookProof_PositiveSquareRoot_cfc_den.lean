-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.cfc_den
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
theorem solution (C : H →L[ℂ] H) (hC : 0 ≤ C) :
    cfc (fun t : ℝ => 1 - t - t + t * t + t * t) C
      = 1 - C - C + C * C + C * C := by

  have hsa : IsSelfAdjoint C := hC.isSelfAdjoint
  rw [cfc_add (R := ℝ) C (fun t : ℝ => 1 - t - t + t * t) (fun t : ℝ => t * t),
    cfc_add (R := ℝ) C (fun t : ℝ => 1 - t - t) (fun t : ℝ => t * t),
    cfc_sub (R := ℝ) (fun t : ℝ => 1 - t) (fun t : ℝ => t) C,
    cfc_sub (R := ℝ) (fun _ : ℝ => 1) (fun t : ℝ => t) C,
    cfc_mul (R := ℝ) (fun t : ℝ => t) (fun t : ℝ => t) C,
    cfc_const_one ℝ C, cfc_id' ℝ C]
