-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.exactStates_le_physicalStates
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstYangMills_bookOmega_nilpotent
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution : exactStates G ≤ physicalStates G := by

  rintro v ⟨w, rfl⟩
  have h := congrArg (fun T : Module.End ℂ (BookState N) => T w) (bookOmega_nilpotent G)
  simpa [physicalStates, LinearMap.mem_ker] using h
