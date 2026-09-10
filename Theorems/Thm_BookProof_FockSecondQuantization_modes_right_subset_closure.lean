-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.modes_right_subset_closure
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

theorem BookProof.FockSecondQuantization.modes_right_subset_closure (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) :
    modes v ⊆ closureModes col u v := by sorry
