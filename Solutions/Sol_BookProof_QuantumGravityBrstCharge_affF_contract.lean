-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.affF_contract
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
theorem solution (x y z w : Fin 19) :
    ∑ e, affF x y e * affF e z w = affEps x y * (if w = 1 then affEps 1 z else 0) := by

  simp only [affF, ite_mul, zero_mul]
  rw [Finset.sum_ite_eq' Finset.univ (1 : Fin 19)]
  simp
