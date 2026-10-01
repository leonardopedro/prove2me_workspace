-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.dGammaOp_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

rm _ _

theorem BookProof.FockSecondQuantization.dGammaOp_quadForm_nonneg {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col)
    (x : lpFiniteModes Conf) : 0 ≤ quadForm (dGammaOp := by sorry
