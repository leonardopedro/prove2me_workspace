-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsDerivBrstCharge2_ne_zero
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsDerivBrstCharge2_apply_tmul
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_ghostComponent_tmul
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : nsDerivBrstCharge2 ≠ 0 := by

  intro h
  have happ : nsDerivBrstCharge2 (X (NSVar.y 0) ⊗ₜ[ℂ] (1 : nsGhostSpace)) = 0 := by
    rw [h]; simp
  rw [nsDerivBrstCharge2_apply_tmul] at happ
  have hterm : ∀ j : Fin 3, j ≠ 0 →
      genY2 j (X (NSVar.y 0)) ⊗ₜ[ℂ] nsGhostCre j (1 : nsGhostSpace) = 0 := by
    intro j hj
    have hzero : genY2 j (X (NSVar.y 0)) = 0 := by
      simp [genY2_apply, pderiv_X, Ne.symm hj]
    rw [hzero, TensorProduct.zero_tmul]
  rw [Finset.sum_eq_single (0 : Fin 3) (fun j _ hj => hterm j hj) (by simp)] at happ
  have h0 : genY2 (0 : Fin 3) (X (NSVar.y 0)) = 1 := by
    simp [genY2_apply, pderiv_X]
  rw [h0] at happ
  have hgh := congrArg ghostComponent happ
  rw [ghostComponent_tmul] at hgh
  simp [nsGhostCre] at hgh
