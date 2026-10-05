-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_creF_left
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_fsign_conj
import Theorems.Thm_BookProof_FermionFock_fsign_erase
import Theorems.Thm_BookProof_FermionFock_creF_apply
import Theorems.Thm_BookProof_FermionFock_annF_apply
import Theorems.Thm_BookProof_FermionFock_inner_toLpF_of_subset
import Theorems.Thm_BookProof_FermionFock_toggle_of_mem
import Theorems.Thm_BookProof_FermionFock_toggle_of_not_mem
import Theorems.Thm_BookProof_FermionFock_toggle_toggle
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u v : FermiAlg) :
    (inner ℂ (toLpF (creF j u)) (toLpF v) : ℂ) = inner ℂ (toLpF u) (toLpF (annF j v)) := by

  classical
  set s : Finset FConf := (creF j u).support ∪ u.support with hs
  set F : Finset FConf := s ∪ s.image (toggle j) with hF
  have hmemF : ∀ S ∈ F, toggle j S ∈ F := by
    intro S hS
    rcases Finset.mem_union.mp hS with h | h
    · exact Finset.mem_union_right _ (Finset.mem_image.mpr ⟨S, h, rfl⟩)
    · obtain ⟨T, hT, hTS⟩ := Finset.mem_image.mp h
      refine Finset.mem_union_left _ ?_
      rw [← hTS, toggle_toggle]
      exact hT
  have hcre : (creF j u).support ⊆ F :=
    fun S hS => Finset.mem_union_left _ (Finset.mem_union_left _ hS)
  have hu : u.support ⊆ F :=
    fun S hS => Finset.mem_union_left _ (Finset.mem_union_right _ hS)
  rw [inner_toLpF_of_subset hcre v, inner_toLpF_of_subset hu (annF j v)]
  refine Finset.sum_nbij' (i := toggle j) (j := toggle j)
    (fun S hS => hmemF S hS) (fun S hS => hmemF S hS)
    (fun S _ => toggle_toggle j S) (fun S _ => toggle_toggle j S) ?_
  intro S _
  by_cases hj : j ∈ S
  · rw [creF_apply, if_pos hj, toggle_of_mem hj, annF_apply,
      if_neg (Finset.notMem_erase j S), fsign_erase, Finset.insert_erase hj, map_mul,
      fsign_conj]
    ring
  · rw [creF_apply, if_neg hj, toggle_of_not_mem hj, annF_apply,
      if_pos (Finset.mem_insert_self j S), map_zero, zero_mul, mul_zero]
