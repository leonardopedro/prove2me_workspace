-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermCre_apply
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
    fermCre j u α = if j ∈ α then jwSign j α * u (α.erase j) else 0 := by

  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg =>
      simp only [map_add, Finsupp.add_apply, hf, hg]
      split <;> ring
  | single β c =>
    rw [fermCre_single]
    by_cases hja : j ∈ α
    · simp only [hja, if_true]
      by_cases hb : β = α.erase j
      · subst hb
        have hjb : j ∉ α.erase j := Finset.notMem_erase j α
        simp only [hjb, if_false, Finset.insert_erase hja, Finsupp.smul_apply,
          Finsupp.single_eq_same, smul_eq_mul, jwSign_erase_self]
        ring
      · have h1 : (Finsupp.single β c : FermAlg) (α.erase j) = 0 := by
          simp [Ne.symm hb]
        rw [h1, mul_zero]
        by_cases hjb : j ∈ β
        · simp [hjb]
        · have hne : insert j β ≠ α := by
            intro h
            exact hb (by rw [← h, Finset.erase_insert hjb])
          simp [hjb, hne]
    · simp only [hja, if_false]
      by_cases hjb : j ∈ β
      · simp [hjb]
      · have hne : insert j β ≠ α := by
          intro h; rw [← h] at hja; exact hja (Finset.mem_insert_self j β)
        simp [hjb, hne]
