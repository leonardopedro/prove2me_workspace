-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.affBRST_nilpotent
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_qgBRST_nilpotent
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_affF_jacobi
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_affMat_close
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_affF_antisymm
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}
variable {α : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : qgBRST affMat affF * qgBRST affMat affF = 0 := qgBRST_nilpotent affMat affF affMat_close affF_antisymm affF_jacobi
