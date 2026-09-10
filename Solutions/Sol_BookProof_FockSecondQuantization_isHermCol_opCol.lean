-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.isHermCol_opCol
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_opCol_apply
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
    (hA : SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp A)) :
    IsHermCol (opCol b A) := by

  intro j k
  have h := hA ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ ⟨b j, Submodule.subset_span ⟨j, rfl⟩⟩
  simp only [LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply] at h
  rw [opCol_apply, opCol_apply, ← h, inner_conj_symm]
