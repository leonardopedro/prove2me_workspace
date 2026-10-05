-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.gaussDer_X
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin N) (i : Fin 4 × Fin N) :
    gaussDer G c (X i) = gaussVec G c i := mkDerivation_X ℂ _ i
