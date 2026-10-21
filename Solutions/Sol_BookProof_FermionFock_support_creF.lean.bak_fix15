-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.support_creF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_creF_apply
import Theorems.Thm_BookProof_FermionFock_toggle_of_not_mem
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermiAlg) :
    (creF j u).support ⊆ u.support.image (toggle j) := by

  classical
  intro S hS
  have hS' := Finsupp.mem_support_iff.mp hS
  rw [creF_apply] at hS'
  by_cases hj : j ∈ S
  · rw [if_pos hj] at hS'
    have hu : u (S.erase j) ≠ 0 := fun h => hS' (by rw [h, mul_zero])
    refine Finset.mem_image.mpr ⟨S.erase j, Finsupp.mem_support_iff.mpr hu, ?_⟩
    rw [toggle_of_not_mem (Finset.notMem_erase j S), Finset.insert_erase hj]
  · rw [if_neg hj] at hS'
    exact absurd rfl hS'
