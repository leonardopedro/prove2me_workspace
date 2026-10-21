-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.qgGhostCar
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_ghost_car
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_ghostOp_mul
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_ghostOp_add
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_ghostOp_one
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_ghostOp_zero
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}
variable {α : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : GhostCAR qgChi qgBeta := by

  classical
  constructor
  · intro a b
    rw [qgChi, qgChi, ← ghostOp_mul, ← ghostOp_mul, ← ghostOp_add, ghost_car.chichi a b,
      ghostOp_zero]
  · intro a b
    rw [qgBeta, qgBeta, ← ghostOp_mul, ← ghostOp_mul, ← ghostOp_add, ghost_car.betabeta a b,
      ghostOp_zero]
  · intro a b
    rw [qgBeta, qgChi, ← ghostOp_mul, ← ghostOp_mul, ← ghostOp_add, ghost_car.betachi a b]
    by_cases h : a = b
    · simp [h, ghostOp_one]
    · simp [h, ghostOp_zero]
