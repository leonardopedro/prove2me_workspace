-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.ghostOpN_zero
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution : ghostOpN (0 : Module.End ℂ (GhostSpace N)) = 0 := by
 simp [ghostOpN]
