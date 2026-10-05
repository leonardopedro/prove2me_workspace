-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bosOpN_zero
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution : bosOpN (0 : Module.End ℂ (FieldPoly N)) = 0 := by
 simp [bosOpN]
