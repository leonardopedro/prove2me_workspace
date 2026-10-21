-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.chi_comm_pair
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_chi_anticomm
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (hCAR : GhostCAR χ β) (a d g : Fin n) :
    χ a * (χ d * χ g) = (χ d * χ g) * χ a := by

  calc χ a * (χ d * χ g) = (χ a * χ d) * χ g := by rw [mul_assoc]
    _ = (-(χ d * χ a)) * χ g := by rw [chi_anticomm hCAR]
    _ = -(χ d * (χ a * χ g)) := by rw [neg_mul, mul_assoc]
    _ = -(χ d * (-(χ g * χ a))) := by rw [chi_anticomm hCAR]
    _ = (χ d * χ g) * χ a := by rw [mul_neg, neg_neg, mul_assoc]
