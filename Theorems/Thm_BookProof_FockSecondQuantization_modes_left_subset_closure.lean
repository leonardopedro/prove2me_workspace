-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.modes_left_subset_closure
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

upport

theorem BookProof.FockSecondQuantization.modes_left_subset_closure (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) :
    modes u ⊆ closureModes := by sorry
