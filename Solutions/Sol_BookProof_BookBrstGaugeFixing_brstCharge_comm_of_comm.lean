-- Generated from ChapterBookBrstGaugeFixing.lean — solution of BookProof.BookBrstGaugeFixing.brstCharge_comm_of_comm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Theorems.Thm_BookProof_BookBrstGaugeFixing_glin_comm_of_comm
import Theorems.Thm_BookProof_BookBrstGaugeFixing_Q_comm_of_comm
open BookProof.BookBrstGaugeFixing




open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}

set_option maxHeartbeats 1000000 in
theorem solution {T : R} (hG : ∀ a, Gc a * T = T * Gc a)
    (hχ : ∀ a, χ a * T = T * χ a) (hβ : ∀ a, β a * T = T * β a) :
    brstCharge f Gc χ β * T = T * brstCharge f Gc χ β := by

  rw [brstCharge, sub_mul, mul_sub, glin_comm_of_comm hG hχ, smul_mul_assoc, mul_smul_comm,
    Q_comm_of_comm hχ hβ]
