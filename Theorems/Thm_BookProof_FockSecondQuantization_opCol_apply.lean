-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.opCol_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

ain b)

theorem BookProof.FockSecondQuantization.opCol_apply (b : HilbertBasis ℕ ℂ F) (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (k j : ℕ) :
    opCol b A k j
      = inner ℂ (b j) ((A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain := by sorry
