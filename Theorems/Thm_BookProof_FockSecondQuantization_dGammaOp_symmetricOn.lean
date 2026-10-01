-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.dGammaOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

Equiv]

theorem BookProof.FockSecondQuantization.dGammaOp_symmetricOn {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) :
    SymmetricOn (lpFiniteModes Conf) (dGamma := by sorry
