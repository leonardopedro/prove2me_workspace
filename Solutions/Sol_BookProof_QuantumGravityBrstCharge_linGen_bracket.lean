-- Generated from ChapterQuantumGravityBrstCharge.lean — solution of BookProof.QuantumGravityBrstCharge.linGen_bracket
import Mathlib
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_elemGen_bracket
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_linGen_sub
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_linGen_prod
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_sum4_swap_blocks
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_sum4_sub_distrib
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_linGen_contract_left
import Theorems.Thm_BookProof_QuantumGravityBrstCharge_linGen_contract_right
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
    linGen A * linGen B - linGen B * linGen A = linGen (A * B - B * A) := by

  have h2 : linGen B * linGen A
      = ∑ j, ∑ k, ∑ l, ∑ m, (A j k * B l m) • (elemGen l m * elemGen j k) := by
    rw [linGen_prod B A,
      sum4_swap_blocks (fun l m j k => (B l m * A j k) • (elemGen (d := d) l m * elemGen j k))]
    exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
      Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by rw [mul_comm (B _ _)]
  rw [linGen_prod A B, h2, sum4_sub_distrib]
  have hterm : ∀ j k l m : Fin d,
      (A j k * B l m) • (elemGen (d := d) j k * elemGen l m)
        - (A j k * B l m) • (elemGen (d := d) l m * elemGen j k)
      = (A j k * B l m) • (if k = l then elemGen (d := d) j m else 0)
        - (A j k * B l m) • (if j = m then elemGen (d := d) l k else 0) := by
    intro j k l m
    rw [← smul_sub, elemGen_bracket, smul_sub]
  rw [Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
    Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun m _ => hterm j k l m,
    ← sum4_sub_distrib, linGen_contract_left, linGen_contract_right, linGen_sub]
