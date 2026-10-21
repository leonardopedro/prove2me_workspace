-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.qgConstraintAlgebra
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_linGen_smul_sum
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_linGen_bracket
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_bosOp_mul
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_bosOp_sub
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_bosOp_smul
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_bosOp_sum
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_bosOp_ghostOp_comm
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}
variable {α : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (M : Fin 19 → Matrix (Fin 84) (Fin 84) ℝ)
    (f : Fin 19 → Fin 19 → Fin 19 → ℝ)
    (hclose : ∀ a b, M a * M b - M b * M a = ∑ e, f a b e • M e) :
    ConstraintAlgebra f (qgConstraint M) qgChi qgBeta where
  comm_chi a b :=
  where
    comm_chi a b := bosOp_ghostOp_comm _ _
    comm_beta a b := bosOp_ghostOp_comm _ _
    bracket a b := by
      simp only [qgConstraint, ← bosOp_mul, ← bosOp_sub, linGen_bracket, hclose a b,
        linGen_smul_sum]
      rw [bosOp_sum]
      exact Finset.sum_congr rfl fun e _ => bosOp_smul _ _
