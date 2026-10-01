-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.dGammaOpB_symmetricOn
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

earMap

theorem BookProof.FockSecondQuantization.dGammaOpB_symmetricOn {ε : ℕ ≃ Conf} {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) :
    SymmetricOn (finiteModeDomain (fockBasisN ε)) (dGammaOpB := by sorry
