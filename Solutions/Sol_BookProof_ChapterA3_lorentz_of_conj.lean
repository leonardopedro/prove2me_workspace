-- Generated from ChapterA3b.lean — solution of BookProof.ChapterA3.lorentz_of_conj
import Mathlib
import Definitions.Def_ChapterA3b
import Theorems.Thm_BookProof_ChapterA3_mgamma_clifford
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (S : Matrix (Fin 4) (Fin 4) ℂ) (hS : IsUnit S.det)
    (Lam : Matrix (Fin 4) (Fin 4) ℝ)
    (hLam : ∀ μ, S⁻¹ * mgamma μ * S = ∑ ν, (Lam μ ν : ℂ) • mgamma ν) :
    Lam * minkowskiMat * Lamᵀ = minkowskiMat := by

  -- By equating the two expressions for `P`, we can conclude that the sums are equal.
  have hP_eq : ∀ (μ ν : Fin 4),    (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) = ∑ α,    ∑
      β, ((Lam μ α : ℂ) * (Lam ν β : ℂ)) • ((mgamma α * mgamma β + mgamma β * mgamma α)) := by
    intro μ ν
    have hP_eq : (S⁻¹ * mgamma μ * S) * (S⁻¹ * mgamma ν * S) + (S⁻¹ * mgamma ν * S) * (S⁻¹ * mgamma
        μ * S) = (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
      simp_all only [isUnit_iff_ne_zero, ne_eq, mul_assoc, Complex.coe_smul, neg_mul, neg_smul];
      simp_all only [← hLam, implies_true, mul_assoc, isUnit_iff_ne_zero, ne_eq, not_false_eq_true,
          mul_nonsing_inv_cancel_left];
      convert congr_arg ( fun x => S⁻¹ * x * S ) ( mgamma_clifford μ ν ) using 1 <;> simp [
          mul_assoc, hS, isUnit_iff_ne_zero ];
      simp only [Matrix.add_mul, mul_assoc, Matrix.mul_add];
    rw [ ← hP_eq, hLam, hLam ];
    simp only [Complex.coe_smul, Finset.mul_sum _ _ _, Algebra.mul_smul_comm, Finset.sum_mul, Algebra.smul_mul_assoc, smul_add, Finset.sum_add_distrib];
    simp only [Finset.smul_sum, smul_smul, mul_comm];
    exact congrArg₂ ( · + · ) ( Finset.sum_comm.trans ( Finset.sum_congr rfl fun _ _ =>
                            Finset.sum_congr rfl fun _ _ => by norm_cast ) ) ( Finset.sum_congr rfl
                                                               fun _ _ => Finset.sum_congr rfl fun _
                                                                   _ => by norm_cast );
  -- By equating the two expressions for `P`, we can conclude that the sums are equal. Use the fact
  -- that `mgamma_clifford` holds.
  have hP_eq' : ∀ (μ ν : Fin 4),    (-2 * minkowski μ ν) • (1 : Matrix (Fin 4) (Fin 4) ℂ) = (-2 * ∑
      α, ∑ β, (Lam μ α : ℂ) * (minkowskiR α β) * (Lam ν β : ℂ)) • (1 : Matrix (Fin 4) (Fin 4) ℂ) :=
          by
    intro μ ν;      rw [ hP_eq μ ν ] ;      simp [ mgamma_clifford, Finset.mul_sum _ _ _,
        mul_left_comm, mul_comm ] ; ring;
    simp [ Finset.sum_smul, smul_smul, mul_assoc, mul_comm, mul_left_comm, minkowski, minkowskiR ];
  ext μ ν; specialize hP_eq' μ ν; simp_all only [isUnit_iff_ne_zero, ne_eq, Complex.coe_smul, ←
      ext_iff, neg_mul, neg_smul, smul_add, neg_inj,
          one_ne_zero, not_false_eq_true, smul_left_inj, mul_eq_mul_left_iff, OfNat.ofNat_ne_zero,
              or_false] ;
  convert congr_arg Complex.re hP_eq'.symm using 1 ;    norm_num [ Complex.ext_iff, Matrix.mul_apply
      ] ; ring;
  have hL : ∀ μ ν : Fin 4,
      (Lam * minkowskiMat * Lamᵀ) μ ν
        = ∑ α : Fin 4, ∑ β : Fin 4, Lam μ α * minkowskiR α β * Lam ν β := by
    intro μ ν
    simp only [minkowskiMat, Matrix.of_apply, Matrix.transpose_apply, Matrix.mul_apply]
    simp only [Finset.sum_mul, mul_assoc]
    rw [Finset.sum_comm]
  exact hL μ ν
  simp [minkowskiMat, minkowskiR, minkowski]
