-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.mem_exactStates_of_comm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstGaugeFixing_bookOmega_comm_of_comm
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
    (hβ : ∀ a, betaOp (N := N) a * T = T * betaOp a)
    {v : BookState N} (hv : v ∈ exactStates G) : T v ∈ exactStates G := by

  obtain ⟨w, rfl⟩ := hv
  have h : bookOmega G (T w) = T (bookOmega G w) :=
    congrArg (fun S : Module.End ℂ (BookState N) => S w) (bookOmega_comm_of_comm G hG hχ hβ)
  exact ⟨T w, h⟩
