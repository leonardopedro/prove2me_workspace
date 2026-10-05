-- Generated from ChapterBookBrstYangMills.lean — solution of BookProof.BookBrstYangMills.bosOpN_smul
import Mathlib
import Definitions.Def_ChapterBookBrstYangMills
open BookProof.BookBrstYangMills




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge

noncomputable section

variable {N : ℕ} (G : GaugeAlgebra N)

set_option maxHeartbeats 1000000 in
theorem solution (r : ℂ) (T : Module.End ℂ (FieldPoly N)) :
    bosOpN (r • T) = r • bosOpN T := by

  refine LinearMap.ext fun x => ?_
  induction x using TensorProduct.induction_on with
  | zero => simp
  | tmul a b => simp [bosOpN, TensorProduct.smul_tmul']
  | add x y hx hy => simp [hx, hy]
