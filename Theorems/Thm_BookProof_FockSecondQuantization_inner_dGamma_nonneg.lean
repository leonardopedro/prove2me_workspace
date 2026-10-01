-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.inner_dGamma_nonneg
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

_conj]

theorem BookProof.FockSecondQuantization.inner_dGamma_nonneg {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col) (u : FockAlg) :
    0 ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : := by sorry
