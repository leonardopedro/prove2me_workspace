-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.annF_eq_zero_of_not_mem_modesF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_annF_apply
import Theorems.Thm_BookProof_FermionFock_mem_modesF
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {u : FermiAlg} {k : ℕ} (h : k ∉ modesF u) :
    annF k u = 0 := by

  classical
  refine Finsupp.ext fun S => ?_
  rw [annF_apply, Finsupp.zero_apply]
  by_cases hk : k ∈ S
  · rw [if_pos hk]
  · rw [if_neg hk]
    have hu : u (insert k S) = 0 := by
      by_contra hc
      exact h (mem_modesF (Finsupp.mem_support_iff.mpr hc) (Finset.mem_insert_self k S))
    rw [hu, mul_zero]
