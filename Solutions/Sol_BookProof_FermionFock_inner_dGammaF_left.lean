-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_dGammaF_left
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_annF_eq_zero_of_not_mem_modesF
import Theorems.Thm_BookProof_FermionFock_dGammaF_eq_sum
import Theorems.Thm_BookProof_FermionFock_inner_creVecF_annF
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u v : FermiAlg) {L : Finset ℕ}
    (hu : modesF u ⊆ L)
    (hL : ∀ k ∈ modesF u ∪ modesF v, (col k).support ⊆ L) :
    (inner ℂ (toLpF (dGammaF col u)) (toLpF v) : ℂ)
      = ∑ k ∈ L, ∑ j ∈ L,
        (starRingEnd ℂ) ((col k) j) * inner ℂ (toLpF (annF k u)) (toLpF (annF j v)) := by

  have hsum : toLpF (dGammaF col u) = ∑ k ∈ L, toLpF (creVecF (col k) (annF k u)) := by
    rw [dGammaF_eq_sum col hu, ← toLpFL_apply, map_sum]
    rfl
  rw [hsum, sum_inner]
  refine Finset.sum_congr rfl fun k _ => ?_
  by_cases hku : k ∈ modesF u
  · exact inner_creVecF_annF col u v k (hL k (Finset.mem_union_left _ hku))
  · have h0 : annF k u = 0 := annF_eq_zero_of_not_mem_modesF hku
    rw [h0, map_zero]
    simp
