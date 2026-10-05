-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_dGammaF_right
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_annF_eq_zero_of_not_mem_modesF
import Theorems.Thm_BookProof_FermionFock_dGammaF_eq_sum
import Theorems.Thm_BookProof_FermionFock_inner_annF_creVecF
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u v : FermiAlg) {L : Finset ℕ}
    (hv : modesF v ⊆ L)
    (hL : ∀ k ∈ modesF u ∪ modesF v, (col k).support ⊆ L) :
    (inner ℂ (toLpF u) (toLpF (dGammaF col v)) : ℂ)
      = ∑ j ∈ L, ∑ k ∈ L,
        (col j) k * inner ℂ (toLpF (annF k u)) (toLpF (annF j v)) := by

  have hsum : toLpF (dGammaF col v) = ∑ j ∈ L, toLpF (creVecF (col j) (annF j v)) := by
    rw [dGammaF_eq_sum col hv, ← toLpFL_apply, map_sum]
    rfl
  rw [hsum, inner_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases hjv : j ∈ modesF v
  · exact inner_annF_creVecF col u v j (hL j (Finset.mem_union_right _ hjv))
  · have h0 : annF j v = 0 := annF_eq_zero_of_not_mem_modesF hjv
    rw [h0, map_zero]
    simp
