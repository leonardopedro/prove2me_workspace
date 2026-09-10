-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.modes_left_subset_closure
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) :
    modes u ⊆ closureModes col u v :=
  fun _ hx =>
    Finset.mem_union_left _ (Finset.mem_union_left _ hx)
