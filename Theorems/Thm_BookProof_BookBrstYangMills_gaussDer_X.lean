-- Generated from ChapterBookBrstYangMills.lean — theorem BookProof.BookBrstYangMills.gaussDer_X
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
import Definitions.Def_ChapterA4

variable {N : ℕ} (G : GaugeAlgebra N)



open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

theorem BookProof.BookBrstYangMills.gaussDer_X (c : Fin N) (i : Fin 4 × Fin N) :
    gaussDer G c (X i) = gaussVec G c i := by sorry
