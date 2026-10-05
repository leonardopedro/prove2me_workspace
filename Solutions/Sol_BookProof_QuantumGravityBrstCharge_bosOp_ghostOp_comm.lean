-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.bosOp_ghostOp_comm
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}
variable {α : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (S : Module.End ℂ qgPoly) (T : Module.End ℂ ghostSpace) :
    bosOp S * ghostOp T = ghostOp T * bosOp S := by

  simp [bosOp, ghostOp, Module.End.mul_eq_comp, LinearMap.lTensor_comp_rTensor,
    LinearMap.rTensor_comp_lTensor]
