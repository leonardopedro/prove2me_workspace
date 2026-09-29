-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsHamiltonian_isPolynomial
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution :
    nsHamiltonian d = ∑ a : NSWordIndex, nsCoeff d.nu a • ((nsWord a).map (nsGen d)).prod := by

  simp only [Fintype.sum_sum_type, Fintype.sum_prod_type, Fintype.sum_bool, nsWord, nsCoeff,
    nsGen, List.map_cons, List.map_nil, List.prod_cons, List.prod_nil, Sum.elim_inl,
    Sum.elim_inr, one_smul, mul_one, nsHamiltonian, nsAdvection, nsVelocity, nsGradVelocity,
    nsLapVelocity]
  simp only [mul_add, add_mul, Finset.mul_sum, Finset.sum_mul, Finset.sum_add_distrib,
    sub_eq_add_neg, mul_neg, neg_mul, Matrix.mul_smul, Matrix.smul_mul, neg_smul, mul_assoc]
  abel
