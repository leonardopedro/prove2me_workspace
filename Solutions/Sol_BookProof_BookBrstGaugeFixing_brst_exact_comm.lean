-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.brst_exact_comm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution {Ω Ψ : R} (hnil : Ω * Ω = 0) :
    Ω * (Ω * Ψ + Ψ * Ω) = (Ω * Ψ + Ψ * Ω) * Ω := by

  have h1 : Ω * (Ω * Ψ) = 0 := by rw [← mul_assoc, hnil, zero_mul]
  have h2 : (Ψ * Ω) * Ω = 0 := by rw [mul_assoc, hnil, mul_zero]
  calc Ω * (Ω * Ψ + Ψ * Ω) = Ω * (Ω * Ψ) + (Ω * Ψ) * Ω := by
        rw [mul_add, mul_assoc]
    _ = (Ω * Ψ) * Ω := by rw [h1, zero_add]
    _ = (Ω * Ψ) * Ω + (Ψ * Ω) * Ω := by rw [h2, add_zero]
    _ = (Ω * Ψ + Ψ * Ω) * Ω := by rw [add_mul]
