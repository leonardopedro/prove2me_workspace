-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.inner_toLp_of_subset
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

g this

theorem BookProof.FockSecondQuantization.inner_toLp_of_subset {u : FockAlg} {s : Finset Conf} (hs : u.support ⊆ s)
    (v : FockAlg) :
    (inner ℂ (toLp u) (toLp v) : ℂ) = ∑ α ∈ s, (starRingEnd ℂ) (u α) := by sorry
