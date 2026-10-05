-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.vecComb_sum
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (κ : Fin n → ℝ) (α : Fin n → ℝ) (β : Fin n → Fin N → ℝ)
    (μ : Fin 4) :
    (∑ h, ((κ h : ℝ) : ℂ) • vecComb (α h) (β h) μ)
      = vecComb (∑ h, κ h * α h) (fun g => ∑ h, κ h * β h g) μ := by

  simp only [vecComb, smul_add, Finset.smul_sum, smul_smul, ← Complex.ofReal_mul]
  rw [Finset.sum_add_distrib, ← Finset.sum_smul, ← Complex.ofReal_sum]
  congr 1
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun g _ => ?_
  rw [← Finset.sum_smul, ← Complex.ofReal_sum]
