-- Generated from ChapterQuantumGravityBrstCharge.lean — theorem BookProof.QuantumGravityBrstCharge.derOp_mulOp
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterQuantumGravity3DGauge
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterA4
open BookProof.YangMillsHermite
open BookProof.QuantumGravityBrstCharge

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}



open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

theorem BookProof.QuantumGravityBrstCharge.derOp_mulOp (k l : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    derOp k (X l * p) = X l * derOp k p + (if k = l then p else 0) := by sorry
