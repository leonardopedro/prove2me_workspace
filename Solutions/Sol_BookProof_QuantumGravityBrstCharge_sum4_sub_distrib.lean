-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.sum4_sub_distrib
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
theorem solution [AddCommGroup α] (F G : Fin d → Fin d → Fin d → Fin d → α) :
    (∑ j, ∑ k, ∑ l, ∑ m, F j k l m) - (∑ j, ∑ k, ∑ l, ∑ m, G j k l m)
      = ∑ j, ∑ k, ∑ l, ∑ m, (F j k l m - G j k l m) := by

  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [← Finset.sum_sub_distrib]
