-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_creVecF_annF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_inner_creF_left
import Theorems.Thm_BookProof_FermionFock_creVecF_apply
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u v : FermiAlg) (k : ℕ) {L : Finset ℕ}
    (h : (col k).support ⊆ L) :
    (inner ℂ (toLpF (creVecF (col k) (annF k u))) (toLpF v) : ℂ)
      = ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
          * inner ℂ (toLpF (annF k u)) (toLpF (annF j v)) := by

  have hexp : toLpF (creVecF (col k) (annF k u))
      = ∑ j ∈ (col k).support, (col k) j • toLpF (creF j (annF k u)) := by
    rw [creVecF_apply, ← toLpFL_apply, map_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, toLpFL_apply]
  rw [hexp, sum_inner, ← Finset.sum_subset h (fun j _ hj => by
    rw [Finsupp.notMem_support_iff.mp hj, map_zero, zero_mul])]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner_smul_left, inner_creF_left]
