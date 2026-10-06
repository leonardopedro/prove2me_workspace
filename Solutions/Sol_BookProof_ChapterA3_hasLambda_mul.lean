-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.hasLambda_mul
import Mathlib
import Definitions.Def_ChapterA3c
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution {S₁ S₂ Λ₁ Λ₂ : Matrix (Fin 4) (Fin 4) ℝ}
    (_h1 : IsUnit S₁.det) (_h2 : IsUnit S₂.det)
    (hL1 : HasLambda S₁ Λ₁) (hL2 : HasLambda S₂ Λ₂) :
    HasLambda (S₁ * S₂) (Λ₁ * Λ₂) := by

  intro μ;
  simp_all only [isUnit_iff_ne_zero, ne_eq, Matrix.mul_inv_rev, mul_assoc];
  convert congr_arg ( fun x => S₂⁻¹ * x * S₂ ) ( hL1 μ ) using 1 <;> simp only [← mul_assoc,
                                                                       Matrix.mul_sum,
                                                                       Algebra.mul_smul_comm,
                                                                       Matrix.sum_mul,
                                                                       Algebra.smul_mul_assoc];
  simp only [mul_apply];
  simp only [Finset.sum_smul];
  rw [ Finset.sum_comm ];
  exact Finset.sum_congr rfl fun _ _ => by rw [ hL2 ] ;    simp [ Finset.smul_sum, smul_smul ] ;
