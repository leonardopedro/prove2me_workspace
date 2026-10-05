-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bosOpN_sub
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (S T : Module.End ℂ (FieldPoly N)) :
    bosOpN (S - T) = bosOpN S - bosOpN T := by
 simp [bosOpN]
