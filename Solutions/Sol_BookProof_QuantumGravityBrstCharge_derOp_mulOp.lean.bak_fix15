-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.derOp_mulOp
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k l : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    derOp k (X l * p) = X l * derOp k p + (if k = l then p else 0) := by

  classical
  simp only [derOp_apply, Derivation.leibniz, MvPolynomial.pderiv_X, Pi.single_apply,
    smul_eq_C_mul]
  by_cases h : k = l
  · subst h; simp; ring
  · simp [h, Ne.symm h]; ring
