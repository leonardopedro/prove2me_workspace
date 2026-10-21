-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_dGammaF_nonneg
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_inner_toLpF_of_subset
import Theorems.Thm_BookProof_FermionFock_inner_dGammaF_right
import Theorems.Thm_BookProof_FermionFock_modesF_right_subset_closure
import Theorems.Thm_BookProof_FermionFock_colF_support_subset_closure
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col) (u : FermiAlg) :
    0 ≤ (inner ℂ (toLpF u) (toLpF (dGammaF col u)) : ℂ).re := by

  classical
  set L := closureModesF col u u with hLdef
  set S : Finset FConf := L.biUnion fun k => (annF k u).support with hSdef
  rw [inner_dGammaF_right col u u (modesF_right_subset_closure col u u)
    (colF_support_subset_closure col u u)]
  have hinner : ∀ k ∈ L, ∀ j : ℕ,
      (inner ℂ (toLpF (annF k u)) (toLpF (annF j u)) : ℂ)
        = ∑ T ∈ S, (starRingEnd ℂ) ((annF k u) T) * (annF j u) T := by
    intro k hk j
    exact inner_toLpF_of_subset (fun T hT => Finset.mem_biUnion.mpr ⟨k, hk, hT⟩) _
  have hstep : (∑ j ∈ L, ∑ k ∈ L, (col j) k * inner ℂ (toLpF (annF k u)) (toLpF (annF j u)))
      = ∑ T ∈ S, ∑ j ∈ L, ∑ k ∈ L,
          (starRingEnd ℂ) ((annF j u) T) * (col k) j * ((annF k u) T) := by
    have h1 : (∑ j ∈ L, ∑ k ∈ L, (col j) k * inner ℂ (toLpF (annF k u)) (toLpF (annF j u)))
        = ∑ j ∈ L, ∑ k ∈ L, ∑ T ∈ S,
            (col j) k * ((starRingEnd ℂ) ((annF k u) T) * (annF j u) T) := by
      refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k hk => ?_
      rw [hinner k hk j, Finset.mul_sum]
    rw [h1]
    rw [Finset.sum_comm (s := L) (t := L)]
    rw [show (∑ k ∈ L, ∑ j ∈ L, ∑ T ∈ S,
          (col j) k * ((starRingEnd ℂ) ((annF k u) T) * (annF j u) T))
        = ∑ k ∈ L, ∑ T ∈ S, ∑ j ∈ L,
          (col j) k * ((starRingEnd ℂ) ((annF k u) T) * (annF j u) T) from
      Finset.sum_congr rfl fun k _ => Finset.sum_comm]
    rw [Finset.sum_comm (s := L) (t := S)]
    refine Finset.sum_congr rfl fun T _ => ?_
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => by ring
  rw [hstep, Complex.re_sum]
  refine Finset.sum_nonneg fun T _ => hpos L fun k => (annF k u) T
