-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.up_injective
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_dn_up
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) : Function.Injective (up j) := by

  intro α β h
  have := congrArg (dn j) h
  simpa using this
