-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaF_eq_sum_aux
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_sum_creVecF_annF_subset
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u : FermiAlg) :
    ∀ K : Finset ℕ, modesF u ⊆ K → dGammaF col u = ∑ k ∈ K, creVecF (col k) (annF k u) := by

  classical
  induction u using Finsupp.induction_linear with
  | zero => intro K _; simp
  | add f g hf hg =>
    intro K hK
    have hL1 : modesF f ⊆ K ∪ (modesF f ∪ modesF g) := fun x hx =>
      Finset.mem_union_right _ (Finset.mem_union_left _ hx)
    have hL2 : modesF g ⊆ K ∪ (modesF f ∪ modesF g) := fun x hx =>
      Finset.mem_union_right _ (Finset.mem_union_right _ hx)
    have hKL : K ⊆ K ∪ (modesF f ∪ modesF g) := Finset.subset_union_left
    rw [map_add, hf _ hL1, hg _ hL2, ← Finset.sum_add_distrib,
      sum_creVecF_annF_subset col (f + g) hKL hK]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [map_add, map_add]
  | single T c =>
    intro K hK
    have hsingle : (Finsupp.single T c : FermiAlg) = c • Finsupp.single T (1 : ℂ) := by
      rw [Finsupp.smul_single, smul_eq_mul, mul_one]
    by_cases hc : c = 0
    · subst hc; simp
    have hT : T ⊆ K := by
      refine fun i hi => hK ?_
      exact Finset.mem_biUnion.mpr ⟨T, Finsupp.mem_support_iff.mpr (by simpa using hc), hi⟩
    have hzero : ∀ k ∈ K, k ∉ T → creVecF (col k) (annF k (Finsupp.single T c)) = 0 := by
      intro k _ hk
      rw [annF_single, if_neg hk, smul_zero, map_zero]
    rw [← Finset.sum_subset hT hzero, dGammaF_single, Finset.smul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [hsingle, map_smul, map_smul]
