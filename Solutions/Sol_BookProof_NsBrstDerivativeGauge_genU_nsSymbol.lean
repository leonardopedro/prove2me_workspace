-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.genU_nsSymbol
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genU_leibniz
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_genU_uField
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) (i m : Fin 3) :
    genU m (nsSymbol nu i) = X (NSVar.uD i m) := by

  have hC : genU m (C nu * X (NSVar.uL i)) = 0 := by
    simp [genU_apply, pderiv_X_of_ne (show NSVar.uL i ≠ NSVar.u m by simp)]
  have huD : ∀ j : Fin 3, genU m (X (NSVar.uD i j)) = 0 := by
    intro j
    simp [genU_apply, pderiv_X_of_ne (show NSVar.uD i j ≠ NSVar.u m by simp)]
  simp only [nsSymbol, map_sub, map_sum, hC, sub_zero, genU_leibniz, huD, mul_zero, add_zero,
    genU_uField]
  simp [ite_mul, Finset.sum_ite_eq]
