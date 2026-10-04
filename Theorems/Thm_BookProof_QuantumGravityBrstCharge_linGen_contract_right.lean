-- Generated from ChapterQuantumGravityBrstCharge.lean — theorem BookProof.QuantumGravityBrstCharge.linGen_contract_right
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterQuantumGravity3DGauge
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterA4
open BookProof.QuantumGravityBrstCharge

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}
variable {α : Type*}



open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

theorem BookProof.QuantumGravityBrstCharge.linGen_contract_right (A B : Matrix (Fin d) (Fin d) ℝ) :
    (∑ j, ∑ k, ∑ l, ∑ m, (A j k * B l m) • (if j = m then elemGen l k else 0))
      = linGen (B * A) := by sorry
