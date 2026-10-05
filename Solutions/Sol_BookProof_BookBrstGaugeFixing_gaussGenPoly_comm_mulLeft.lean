-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.gaussGenPoly_comm_mulLeft
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin N) (p : FieldPoly N) :
    gaussGenPoly G c * LinearMap.mulLeft ℂ p - LinearMap.mulLeft ℂ p * gaussGenPoly G c
      = LinearMap.mulLeft ℂ (gaussDer G c p) := by

  refine LinearMap.ext fun q => ?_
  simp only [LinearMap.sub_apply, Module.End.mul_apply, LinearMap.mulLeft_apply]
  change gaussDer G c (p * q) - p * gaussDer G c q = gaussDer G c p * q
  rw [Derivation.leibniz, smul_eq_mul, smul_eq_mul, mul_comm q (gaussDer G c p)]
  ring
