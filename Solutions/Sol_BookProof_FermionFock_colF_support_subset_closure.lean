-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.colF_support_subset_closure
import Mathlib
import Definitions.Def_ChapterFermionFock
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u v : FermiAlg) :
    ∀ k ∈ modesF u ∪ modesF v, (col k).support ⊆ closureModesF col u v := by

  intro k hk i hi
  exact Finset.mem_union_right _ (Finset.mem_biUnion.mpr ⟨k, hk, hi⟩)
