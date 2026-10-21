-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.cfc_gFun_mul_den
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_den_pos
import Theorems.Thm_BookProof_PositiveSquareRoot_continuous_gFun
import Theorems.Thm_BookProof_PositiveSquareRoot_cfc_den
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
theorem solution (C : H →L[ℂ] H) (hC : 0 ≤ C) :
    cfc gFun C * (1 - C - C + C * C + C * C) = C * C := by

  have hsa : IsSelfAdjoint C := hC.isSelfAdjoint
  have hmul : cfc (fun t : ℝ => gFun t * (1 - t - t + t * t + t * t)) C
      = cfc gFun C * cfc (fun t : ℝ => 1 - t - t + t * t + t * t) C := by
    rw [cfc_mul (R := ℝ) _ _ C]
  have hcongr : cfc (fun t : ℝ => gFun t * (1 - t - t + t * t + t * t)) C
      = cfc (fun t : ℝ => t * t) C := by
    refine cfc_congr fun t _ => ?_
    rw [gFun, div_mul_cancel₀ _ (ne_of_gt (den_pos t))]
  have hsquare : cfc (fun t : ℝ => t * t) C = C * C := by
    rw [cfc_mul (R := ℝ) (fun t : ℝ => t) (fun t : ℝ => t) C, cfc_id' ℝ C]
  rw [← cfc_den C hC, ← hmul, hcongr, hsquare]
