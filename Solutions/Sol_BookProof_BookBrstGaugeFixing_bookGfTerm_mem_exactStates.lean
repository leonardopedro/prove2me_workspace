-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.bookGfTerm_mem_exactStates
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstGaugeFixing_bookGfTerm_brst_closed
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution {v : BookState N} (hv : v ∈ exactStates G) :
    bookGfTerm G v ∈ exactStates G := by

  obtain ⟨w, rfl⟩ := hv
  have h : bookOmega G (bookGfTerm G w) = bookGfTerm G (bookOmega G w) :=
    congrArg (fun T : Module.End ℂ (BookState N) => T w) (bookGfTerm_brst_closed G)
  exact ⟨bookGfTerm G w, h⟩
