-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.bookGfTerm_brst_closed
import Mathlib
import Theorems.Thm_BookProof_BookBrstGaugeFixing_brst_exact_comm
import Theorems.Thm_BookProof_BookBrstYangMills_bookOmega_nilpotent
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution :
    bookOmega G * bookGfTerm G = bookGfTerm G * bookOmega G := brst_exact_comm (bookOmega_nilpotent G)
