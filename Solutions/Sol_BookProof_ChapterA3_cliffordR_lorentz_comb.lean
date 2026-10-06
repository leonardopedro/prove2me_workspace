-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.cliffordR_lorentz_comb
import Mathlib
import Definitions.Def_ChapterA3c
import Theorems.Thm_BookProof_ChapterA3_mgammaR_clifford
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (Λ : Matrix (Fin 4) (Fin 4) ℝ) (hΛ : Λ ∈ LorentzO) :
    IsCliffordR (fun μ => ∑ ν, Λ μ ν • mgammaR ν) := by

  intro μ ν;
  -- By definition of matrix multiplication and the properties of the Majorana matrices, we can
  -- expand the products.
  have h_expand : (∑ α, Λ μ α • mgammaR α) * (∑ β, Λ ν β • mgammaR β) +
      (∑ β, Λ ν β • mgammaR β) * (∑ α, Λ μ α • mgammaR α) =
      ∑ α, ∑ β, (Λ μ α * Λ ν β) • (mgammaR α * mgammaR β + mgammaR β * mgammaR α) := by
        simp only [Finset.mul_sum _ _ _, mul_smul_comm, Finset.sum_mul, smul_mul_assoc, smul_add];
        simp only [Finset.smul_sum, smul_smul, mul_comm, Finset.sum_add_distrib];
        rw [ Finset.sum_comm ];
  -- By definition of matrix multiplication and the properties of the Majorana matrices, we can
  -- simplify the expression.
  have h_simplify : ∑ α, ∑ β, (Λ μ α * Λ ν β) • (mgammaR α * mgammaR β + mgammaR β * mgammaR α) =
      ∑ α, ∑ β, (Λ μ α * Λ ν β) • ((-2 * minkowskiR α β) • 1) := by
        exact Finset.sum_congr rfl fun i hi => Finset.sum_congr rfl fun j hj =>
            by rw [ mgammaR_clifford i j ] ;
  -- By definition of matrix multiplication and the properties of the Minkowski metric, we can
  -- simplify the expression.
  have h_final : ∑ α, ∑ β, (Λ μ α * Λ ν β) • (-2 * minkowskiR α β) • (1 : Matrix (Fin 4) (Fin 4) ℝ)
      =
      (-2 * (Λ * minkowskiMat * Λᵀ) μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
        simp only [neg_mul, neg_smul, smul_neg, Finset.sum_neg_distrib, mul_apply, transpose_apply,
            Finset.sum_mul, mul_assoc, Finset.mul_sum _ _ _, mul_left_comm, mul_neg, neg_inj];
        simp only [minkowskiMat, of_apply, mul_comm, mul_left_comm, Finset.sum_smul];
        exact Finset.sum_comm.trans ( Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _
            => by simp [ mul_assoc, smul_smul ] );
  exact h_expand.trans <| h_simplify.trans <| h_final.trans <| by rw [ hΛ ] ; rfl;
