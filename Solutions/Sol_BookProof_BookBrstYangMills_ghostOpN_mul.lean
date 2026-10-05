-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.ghostOpN_mul
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (S T : Module.End ℂ (GhostSpace N)) :
    ghostOpN (S * T) = ghostOpN S * ghostOpN T := by

  simp [ghostOpN, Module.End.mul_eq_comp, LinearMap.lTensor_comp]
