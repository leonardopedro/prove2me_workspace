-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.opCol_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_coordFinsupp_apply
open BookProof.FockSecondQuantization




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
ain b)

theorem solution (b : HilbertBasis ℕ ℂ F) (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (k j : ℕ) :
    opCol b A k j
      = inner ℂ (b j) ((A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain :=
  b) : F) :=
    coordFinsupp_apply (A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomai
