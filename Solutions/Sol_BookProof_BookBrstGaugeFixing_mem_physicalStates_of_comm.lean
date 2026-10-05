-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.mem_physicalStates_of_comm
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
    {v : BookState N} (hv : v ∈ physicalStates G) : T v ∈ physicalStates G := by

  have h : bookOmega G (T v) = T (bookOmega G v) :=
    congrArg (fun S : Module.End ℂ (BookState N) => S v) (bookOmega_comm_of_comm G hG hχ hβ)
  have hv' : bookOmega G v = 0 := hv
  exact (h.trans (by rw [hv', map_zero]) : bookOmega G (T v) = 0)
