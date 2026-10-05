-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.strProd_swap12
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (p q r s : Fin N) : strProd G p q r s = -strProd G q p r s := by

  simp only [strProd, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun m _ => by rw [G.antisymm p q m]; ring
