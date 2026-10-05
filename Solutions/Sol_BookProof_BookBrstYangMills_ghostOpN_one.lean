-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.ghostOpN_one
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution : ghostOpN (1 : Module.End ℂ (GhostSpace N)) = 1 := by

  simp [ghostOpN, Module.End.one_eq_id, LinearMap.lTensor_id]
