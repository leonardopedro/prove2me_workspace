-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.coe_fockEquiv_symm
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_coe_fockEquiv
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes Conf) :
    ((x : lpFiniteModes Conf) : Fock) = toLp (fockEquiv.symm x) := by

  rw [← coe_fockEquiv, LinearEquiv.apply_symm_apply]
