-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.creA_single
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (β : Conf) (c : ℂ) :
    creA j (Finsupp.single β c)
      = c • Finsupp.single (up j β) ((Real.sqrt ((β j : ℝ) + 1) : ℝ) : ℂ) := by

  simp [creA, LinearMap.toSpanSingleton]
