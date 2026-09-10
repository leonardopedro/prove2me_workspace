-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.isPosCol_opCol
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FockSecondQuantization.isPosCol_opCol {b : HilbertBasis ℕ ℂ F}
    {A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    (hpos : ∀ x, 0 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    IsPosCol (opCol b A) := by sorry
