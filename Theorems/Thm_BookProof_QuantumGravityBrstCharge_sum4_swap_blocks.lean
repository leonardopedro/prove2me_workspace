-- Generated from ChapterQuantumGravityBrstCharge.lean — theorem BookProof.QuantumGravityBrstCharge.sum4_swap_blocks
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterQuantumGravity3DGauge
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

theorem BookProof.QuantumGravityBrstCharge.sum4_swap_blocks [AddCommMonoid α] (F : Fin d → Fin d → Fin d → Fin d → α) :
    ∑ l, ∑ m, ∑ j, ∑ k, F l m j k = ∑ j, ∑ k, ∑ l, ∑ m, F l m j k := by sorry
