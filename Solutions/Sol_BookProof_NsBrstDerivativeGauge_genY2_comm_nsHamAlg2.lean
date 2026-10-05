-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.genY2_comm_nsHamAlg2
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genY2_comm_genU
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) (j : Fin 3) :
    genY2 j * nsHamAlg2 nu = nsHamAlg2 nu * genY2 j := by

  rw [nsHamAlg2, Finset.mul_sum, Finset.sum_mul]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hM : genY2 j * mulOp (nsSymbol2 nu i) = mulOp (nsSymbol2 nu i) * genY2 j :=
    comm_mulOp_of_apply_eq_zero (genY2 j) (genY2_leibniz j) (genY2_nsSymbol2 nu i j)
  have hX : genY2 j * genU i = genU i * genY2 j := genY2_comm_genU i j
  have h1 : genY2 j * (genU i * mulOp (nsSymbol2 nu i))
      = (genU i * mulOp (nsSymbol2 nu i)) * genY2 j := by
    rw [← mul_assoc, hX, mul_assoc, hM, ← mul_assoc]
  have h2 : genY2 j * (mulOp (nsSymbol2 nu i) * genU i)
      = (mulOp (nsSymbol2 nu i) * genU i) * genY2 j := by
    rw [← mul_assoc, hM, mul_assoc, hX, ← mul_assoc]
  rw [mul_add, add_mul, h1, h2]
