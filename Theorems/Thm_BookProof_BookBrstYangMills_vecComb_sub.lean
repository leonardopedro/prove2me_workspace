-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.vecComb_sub
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

theorem BookProof.BookBrstYangMills.vecComb_sub (α α' : ℝ) (β β' : Fin N → ℝ) (μ : Fin 4) :
    vecComb α β μ - vecComb α' β' μ = vecComb (α - α') (fun g => β g - β' g) μ := by sorry
