-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.glin_comm_of_comm
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
theorem solution {T : R} (hG : ∀ a, Gc a * T = T * Gc a)
    (hχ : ∀ a, χ a * T = T * χ a) : glin Gc χ * T = T * glin Gc χ := by

  simp only [glin, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [mul_assoc, hχ a, ← mul_assoc, hG a, mul_assoc]
