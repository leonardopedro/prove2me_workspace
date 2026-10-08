-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.gaussDer_apply
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

theorem BookProof.BookBrstYangMills.gaussDer_apply (c : Fin N) (p : FieldPoly N) :
    gaussDer G c p = ∑ i : Fin 4 × Fin N, gaussVec G c i * pderiv i p := by sorry
