-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.dGammaOpB_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

ε) y)

theorem BookProof.FockSecondQuantization.dGammaOpB_quadForm_nonneg {ε : ℕ ≃ Conf} {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col)
    (x : finiteModeDomain (fockBasisN ε)) : 0 ≤ quadForm (dGammaOpB ε := by sorry
