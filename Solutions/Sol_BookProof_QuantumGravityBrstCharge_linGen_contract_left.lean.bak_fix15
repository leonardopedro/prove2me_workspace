-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.linGen_contract_left
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_linGen_def
open BookProof.QuantumGravityBrstCharge




open MvPolynomial BookProof.BRSTNilpotent BookProof.YangMillsHermite
open BookProof.QuantumGravity3DGauge

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {G χ β : Fin n → R}
variable {d : ℕ}
variable {α : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (A B : Matrix (Fin d) (Fin d) ℝ) :
    (∑ j, ∑ k, ∑ l, ∑ m, (A j k * B l m) • (if k = l then elemGen j m else 0))
      = linGen (A * B) := by

  classical
  have step1 : ∀ j k : Fin d,
      (∑ l, ∑ m, (A j k * B l m) • (if k = l then elemGen (d := d) j m else 0))
        = ∑ m, (A j k * B k m) • elemGen j m := by
    intro j k
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun m _ => ?_
    simp [Finset.sum_ite_eq]
  rw [Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => step1 j k, linGen_def]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [← Finset.sum_smul, Matrix.mul_apply]
