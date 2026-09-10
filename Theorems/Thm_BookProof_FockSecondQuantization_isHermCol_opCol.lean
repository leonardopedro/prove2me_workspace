-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.isHermCol_opCol
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FockSecondQuantization.isHermCol_opCol {b : HilbertBasis ℕ ℂ F}
    {A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    (hA : SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp A)) :
    IsHermCol (opCol b A) := by sorry
