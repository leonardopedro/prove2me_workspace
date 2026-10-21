-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.bookGfTerm_mem_physicalStates
import Mathlib
import Theorems.Thm_BookProof_BookBrstGaugeFixing_bookGfTerm_brst_closed
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution {v : BookState N} (hv : v ∈ physicalStates G) :
    bookGfTerm G v ∈ physicalStates G := by

  have h : bookOmega G (bookGfTerm G v) = bookGfTerm G (bookOmega G v) :=
    congrArg (fun T : Module.End ℂ (BookState N) => T v) (bookGfTerm_brst_closed G)
  have hv' : bookOmega G v = 0 := hv
  exact (h.trans (by rw [hv', map_zero]) : bookOmega G (bookGfTerm G v) = 0)
