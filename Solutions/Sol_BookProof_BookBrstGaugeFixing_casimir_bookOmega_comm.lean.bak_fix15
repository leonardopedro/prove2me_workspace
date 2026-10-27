-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.casimir_bookOmega_comm
import Mathlib
import Theorems.Thm_BookProof_BookBrstGaugeFixing_bookOmega_comm_multOp
import Theorems.Thm_BookProof_BookBrstGaugeFixing_gaussDer_casimirPoly
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution (hD : ∀ μ c a, G.D μ c a = 0) :
    bookOmega G * multOp (casimirPoly (N := N)) = multOp (casimirPoly (N := N)) * bookOmega G := bookOmega_comm_multOp G (gaussDer_casimirPoly G hD)
