-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.bookOmega_comm_of_comm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstGaugeFixing_brstCharge_comm_of_comm
import Theorems.Thm_BookProof_BookBrstYangMills_bookOmega_eq_brstCharge
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution {T : Module.End ℂ (BookState N)}
    (hG : ∀ a, gaussGen G a * T = T * gaussGen G a)
    (hχ : ∀ a, chiOp (N := N) a * T = T * chiOp a)
    (hβ : ∀ a, betaOp (N := N) a * T = T * betaOp a) :
    bookOmega G * T = T * bookOmega G := by

  rw [bookOmega_eq_brstCharge, smul_mul_assoc, mul_smul_comm, brstCharge_comm_of_comm hG hχ hβ]
