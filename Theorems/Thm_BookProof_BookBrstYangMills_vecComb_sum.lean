-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.vecComb_sum
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

theorem BookProof.BookBrstYangMills.vecComb_sum {n : ℕ} (κ : Fin n → ℝ) (α : Fin n → ℝ) (β : Fin n → Fin N → ℝ)
    (μ : Fin 4) :
    (∑ h, ((κ h : ℝ) : ℂ) • vecComb (α h) (β h) μ)
      = vecComb (∑ h, κ h * α h) (fun g => ∑ h, κ h * β h g) μ := by sorry
