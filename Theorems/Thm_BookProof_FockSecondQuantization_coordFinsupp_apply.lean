-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.coordFinsupp_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.FockSecondQuantization.coordFinsupp_apply {b : HilbertBasis ℕ ℂ F} {x : F} (hx : x ∈ finiteModeDomain b)
    (j : ℕ) : coordFinsupp b x j = inner ℂ (b j) x := by sorry
