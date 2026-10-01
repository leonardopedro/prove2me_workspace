-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.inner_toLp
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

o_mul]

theorem BookProof.FockSecondQuantization.inner_toLp (u v : FockAlg) :
    (inner ℂ (toLp u) (toLp v) : ℂ) = ∑ α ∈ u.support, (starRingEnd ℂ) (u α) := by sorry
