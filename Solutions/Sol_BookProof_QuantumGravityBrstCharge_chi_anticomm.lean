-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.chi_anticomm
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (hCAR : GhostCAR χ β) (a b : Fin n) : χ a * χ b = -(χ b * χ a) := eq_neg_of_add_eq_zero_left (hCAR.chichi a b)
