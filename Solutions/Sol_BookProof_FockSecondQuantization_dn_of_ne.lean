-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.dn_of_ne
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {i j : ℕ} (α : Conf) (h : i ≠ j) : dn j α i = α i := by

  simp [dn, Finsupp.update_apply, h]
