-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.AfieldPoly_apply
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.AfieldPoly_apply (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    AfieldPoly μ a p = X (μ, a) * p := by sorry
