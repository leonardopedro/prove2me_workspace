-- Generated from ChapterBookBrstInstances.lean — solution of BookProof.BookBrstInstances.sp_swap12
import Mathlib
import Definitions.Def_ChapterBookBrstInstances
open BookProof.BookBrstInstances




open BookProof.BookBrstYangMills BookProof.BookBrstGaugeFixing BookProof.SmBrstGhost
open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open MvPolynomial

noncomputable section

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

variable {N : ℕ} (f : Fin N → Fin N → Fin N → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (hanti : ∀ a b c, f a b c = -f b a c) (p q r s : Fin N) :
    sp f p q r s = -sp f q p r s := by

  simp only [sp, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [hanti p q m]; ring
