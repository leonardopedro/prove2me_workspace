-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.inner_fermCre_left
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_conj_jwSign
import Theorems.Thm_BookProof_QuantumGravityFock_fermAnn_apply
import Theorems.Thm_BookProof_QuantumGravityFock_fermToLp_add
import Theorems.Thm_BookProof_QuantumGravityFock_inner_fermToLp_of_subset
import Theorems.Thm_BookProof_QuantumGravityFock_inner_fermToLp_single
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u v : FermAlg) :
    (inner ℂ (fermToLp (fermCre j u)) (fermToLp v) : ℂ)
      = inner ℂ (fermToLp u) (fermToLp (fermAnn j v)) := by

  classical
  induction u using Finsupp.induction_linear with
  | zero => rw [map_zero, fermToLp_zero, inner_zero_left, inner_zero_left]
  | add f g hf hg =>
      rw [map_add, fermToLp_add, fermToLp_add, inner_add_left, inner_add_left, hf, hg]
  | single β c =>
    induction v using Finsupp.induction_linear with
    | zero => rw [map_zero, fermToLp_zero, inner_zero_right, inner_zero_right]
    | add f g hf hg =>
        rw [map_add, fermToLp_add, fermToLp_add, inner_add_right, inner_add_right, hf, hg]
    | single α d =>
      by_cases hjb : j ∈ β
      · have h0 : fermCre j (Finsupp.single β c) = 0 := by simp [hjb]
        rw [h0, fermToLp_zero, inner_zero_left,
          inner_fermToLp_of_subset (s := {β}) Finsupp.support_single_subset,
          Finset.sum_singleton, fermAnn_apply, if_pos hjb, mul_zero]
      · have h1 : fermCre j (Finsupp.single β c)
            = Finsupp.single (insert j β) (c * jwSign j β) := by
          simp [hjb, Finsupp.smul_single]
        rw [h1, inner_fermToLp_single,
          inner_fermToLp_of_subset (s := {β}) Finsupp.support_single_subset,
          Finset.sum_singleton, Finsupp.single_eq_same, fermAnn_apply, if_neg hjb,
          Finsupp.single_apply]
        by_cases hα : α = insert j β
        · subst hα
          simp [map_mul, conj_jwSign]
          ring
        · simp [hα]
