-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.Q_comm_of_comm
import Mathlib
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution {T : R} (hχ : ∀ a, χ a * T = T * χ a)
    (hβ : ∀ a, β a * T = T * β a) : Q f χ β * T = T * Q f χ β := by

  simp only [Q, Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun e _ => ?_
  rw [smul_mul_assoc, mul_smul_comm]
  congr 1
  calc χ a * χ b * β e * T = χ a * (χ b * (β e * T)) := by noncomm_ring
    _ = χ a * (χ b * (T * β e)) := by rw [hβ]
    _ = χ a * (χ b * T * β e) := by noncomm_ring
    _ = χ a * (T * χ b * β e) := by rw [hχ]
    _ = χ a * T * (χ b * β e) := by noncomm_ring
    _ = T * χ a * (χ b * β e) := by rw [hχ]
    _ = T * (χ a * χ b * β e) := by noncomm_ring
