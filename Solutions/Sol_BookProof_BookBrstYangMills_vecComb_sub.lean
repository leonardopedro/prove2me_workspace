-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.vecComb_sub
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (α α' : ℝ) (β β' : Fin N → ℝ) (μ : Fin 4) :
    vecComb α β μ - vecComb α' β' μ = vecComb (α - α') (fun g => β g - β' g) μ := by

  simp only [vecComb, Complex.ofReal_sub, sub_smul, Finset.sum_sub_distrib]
  abel
