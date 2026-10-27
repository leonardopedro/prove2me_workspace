-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.gfFermion_eq_zero
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution {R : Type*} [Ring R] {n : ℕ} {β B : Fin n → R}
    (h : ∀ d : Fin n, B d = 0) : gfFermion β B = 0 := by

  unfold gfFermion
  exact Finset.sum_eq_zero fun d _ => by rw [h d, mul_zero]
