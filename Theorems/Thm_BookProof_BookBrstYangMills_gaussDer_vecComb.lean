-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.gaussDer_vecComb
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterA4

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.gaussDer_vecComb (c : Fin N) (α : ℝ) (β : Fin N → ℝ) (μ : Fin 4) :
    gaussDer G c (vecComb α β μ)
      = vecComb (∑ b, β b * (-(G.D μ c b))) (fun g => ∑ b, β b * G.f b g c) μ := by sorry
