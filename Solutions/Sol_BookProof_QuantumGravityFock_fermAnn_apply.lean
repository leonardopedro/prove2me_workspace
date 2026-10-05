-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermAnn_apply
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermAlg) (α : FermConf) :
    fermAnn j u α = if j ∈ α then 0 else jwSign j α * u (insert j α) := by

  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg =>
      simp only [map_add, Finsupp.add_apply, hf, hg]
      split <;> ring
  | single β c =>
    rw [fermAnn_single]
    by_cases hja : j ∈ α
    · simp only [hja, if_true]
      by_cases hjb : j ∈ β
      · have hne : β.erase j ≠ α := by
          intro h; rw [← h] at hja; exact (Finset.notMem_erase j β) hja
        simp [hjb, Ne.symm hne]
      · simp [hjb]
    · simp only [hja, if_false]
      by_cases hb : β = insert j α
      · subst hb
        have hjb : j ∈ insert j α := Finset.mem_insert_self j α
        simp only [hjb, if_true, Finset.erase_insert hja, Finsupp.smul_apply,
          Finsupp.single_eq_same, smul_eq_mul, jwSign_insert_self]
        ring
      · have h1 : (Finsupp.single β c : FermAlg) (insert j α) = 0 := by
          simp [Ne.symm hb]
        rw [h1, mul_zero]
        by_cases hjb : j ∈ β
        · have hne : β.erase j ≠ α := by
            intro h
            exact hb (by rw [← h, Finset.insert_erase hjb])
          simp [hjb, hne]
        · simp [hjb]
