-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.isPosCol_opCol
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_opCol_apply
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {b : HilbertBasis ℕ ℂ F}
    {A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    (hpos : ∀ x, 0 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    IsPosCol (opCol b A) := by

  intro S c
  classical
  set x : finiteModeDomain b :=
    ∑ k ∈ S, c k • (⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain b) with hxdef
  have hxc : ((x : finiteModeDomain b) : F) = ∑ k ∈ S, c k • b k := by
    rw [hxdef, Submodule.coe_sum]
    exact Finset.sum_congr rfl fun k _ => rfl
  have hAx : ((A x : finiteModeDomain b) : F)
      = ∑ k ∈ S, c k • ((A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain b) : F) := by
    rw [hxdef, map_sum, Submodule.coe_sum]
    exact Finset.sum_congr rfl fun k _ => by rw [map_smul]; rfl
  have hval : (inner ℂ ((x : finiteModeDomain b) : F)
        (((finiteModeDomain b).subtype.comp A) x) : ℂ)
      = ∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * opCol b A k j * c k := by
    change (inner ℂ ((x : finiteModeDomain b) : F)
      ((A x : finiteModeDomain b) : F) : ℂ) = _
    rw [hxc, hAx, sum_inner]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [inner_smul_left, inner_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [inner_smul_right, opCol_apply]
    ring
  have hq := hpos x
  rw [quadForm, hval] at hq
  exact hq
