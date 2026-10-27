-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.bookGfTerm_eq_zero_of_Afield0
import Mathlib
import Theorems.Thm_BookProof_BookBrstGaugeFixing_bookGfFermion_eq_zero_of_Afield0
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution
    (hA0 : ∀ a : Fin N, Afield (N := N) 0 a = 0) :
    bookGfTerm G = 0 := by

  rw [bookGfTerm, bookGfFermion_eq_zero_of_Afield0 hA0, zero_mul, mul_zero, add_zero]
