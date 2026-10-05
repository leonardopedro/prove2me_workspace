-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.sum4_swap_blocks
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
theorem solution [AddCommMonoid α] (F : Fin d → Fin d → Fin d → Fin d → α) :
    ∑ l, ∑ m, ∑ j, ∑ k, F l m j k = ∑ j, ∑ k, ∑ l, ∑ m, F l m j k := by

  calc ∑ l, ∑ m, ∑ j, ∑ k, F l m j k
      = ∑ l, ∑ j, ∑ m, ∑ k, F l m j k := Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ j, ∑ l, ∑ m, ∑ k, F l m j k := Finset.sum_comm
    _ = ∑ j, ∑ l, ∑ k, ∑ m, F l m j k :=
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm
    _ = ∑ j, ∑ k, ∑ l, ∑ m, F l m j k := Finset.sum_congr rfl fun _ _ => Finset.sum_comm
