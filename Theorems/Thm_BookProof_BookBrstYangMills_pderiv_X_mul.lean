-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.pderiv_X_mul
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterA4
open BookProof.BookBrstYangMills

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.pderiv_X_mul (i j : Fin 4 × Fin N) (p : FieldPoly N) :
    (pderiv i : Derivation ℂ (FieldPoly N) (FieldPoly N)) (X j * p)
      = (if i = j then p else 0) + X j * pderiv i p := by sorry
