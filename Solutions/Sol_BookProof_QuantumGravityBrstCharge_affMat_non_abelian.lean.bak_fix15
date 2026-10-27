-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.affMat_non_abelian
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}
variable {α : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : affMat 0 * affMat 1 ≠ affMat 1 * affMat 0 := by

  intro hcon
  have h : (affMat 0 * affMat 1) 0 1 = (affMat 1 * affMat 0) 0 1 := by rw [hcon]
  simp [affMat, show (1 : Fin 84) ≠ 0 by decide] at h
