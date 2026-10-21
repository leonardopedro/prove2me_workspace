-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.elemGen_bracket
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_derOp_mulOp
import Theorems.Thm_BookProof_QuantumGravity3DGauge_derOp_comm
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (j k l m : Fin d) :
    elemGen j k * elemGen l m - elemGen l m * elemGen j k
      = (if k = l then elemGen j m else 0) - (if j = m then elemGen l k else 0) := by

  classical
  refine LinearMap.ext fun p => ?_
  have hcomm : derOp k (derOp m p) = derOp m (derOp k p) := derOp_comm k m p
  have hswap : (if m = j then (derOp k) p else 0) = (if j = m then derOp k p else 0) := by
    by_cases h : j = m
    · simp [h]
    · simp [h, Ne.symm h]
  have hR : ((if k = l then elemGen j m else 0) - (if j = m then elemGen (d := d) l k else 0)) p
      = (if k = l then X j * derOp m p else 0) - (if j = m then X l * derOp k p else 0) := by
    by_cases h1 : k = l <;> by_cases h2 : j = m <;> simp [h1, h2, elemGen_apply]
  rw [hR]
  simp only [LinearMap.sub_apply, Module.End.mul_apply, elemGen_apply, derOp_mulOp, mul_add,
    hcomm, mul_ite, mul_zero, hswap]
  ring
