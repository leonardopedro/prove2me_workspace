-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bosOpN_sum2
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Theorems.Thm_BookProof_BookBrstYangMills_bosOpN_sum
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (T : Fin 4 → Fin N → Module.End ℂ (FieldPoly N)) :
    bosOpN (∑ μ, ∑ a, T μ a) = ∑ μ, ∑ a, bosOpN (T μ a) := by

  rw [bosOpN_sum]
  exact Finset.sum_congr rfl fun μ _ => bosOpN_sum _
