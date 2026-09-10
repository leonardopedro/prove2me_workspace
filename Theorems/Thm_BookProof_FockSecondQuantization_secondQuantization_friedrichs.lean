-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.secondQuantization_friedrichs
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FockSecondQuantization.secondQuantization_friedrichs (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (hA : SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp A))
    (hpos : ∀ x, 0 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    ∃ (Dom : Submodule ℂ Fock) (A' : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (opCol b A)) A' := by sorry
