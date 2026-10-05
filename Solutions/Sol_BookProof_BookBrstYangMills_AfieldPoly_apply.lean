-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.AfieldPoly_apply
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) (a : Fin N) (p : FieldPoly N) :
    AfieldPoly μ a p = X (μ, a) * p := rfl
