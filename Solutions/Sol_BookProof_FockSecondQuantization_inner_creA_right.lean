-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.inner_creA_right
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_inner_creA_left
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u v : FockAlg) :
    (inner ℂ (toLp u) (toLp (creA j v)) : ℂ) = inner ℂ (toLp (annA j u)) (toLp v) := by

  have h := inner_creA_left j v u
  have := congrArg (starRingEnd ℂ) h
  rwa [inner_conj_symm, inner_conj_symm] at this
