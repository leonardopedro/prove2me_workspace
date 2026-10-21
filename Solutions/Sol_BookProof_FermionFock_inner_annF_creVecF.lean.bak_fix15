-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_annF_creVecF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_inner_creF_right
import Theorems.Thm_BookProof_FermionFock_creVecF_apply
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u v : FermiAlg) (j : ℕ) {L : Finset ℕ}
    (h : (col j).support ⊆ L) :
    (inner ℂ (toLpF u) (toLpF (creVecF (col j) (annF j v))) : ℂ)
      = ∑ k ∈ L, (col j) k * inner ℂ (toLpF (annF k u)) (toLpF (annF j v)) := by

  have hexp : toLpF (creVecF (col j) (annF j v))
      = ∑ k ∈ (col j).support, (col j) k • toLpF (creF k (annF j v)) := by
    rw [creVecF_apply, ← toLpFL_apply, map_sum]
    exact Finset.sum_congr rfl fun k _ => by rw [map_smul, toLpFL_apply]
  rw [hexp, inner_sum, ← Finset.sum_subset h (fun k _ hk => by
    rw [Finsupp.notMem_support_iff.mp hk, zero_mul])]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [inner_smul_right, inner_creF_right]
