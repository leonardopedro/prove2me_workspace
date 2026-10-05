-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.coe_fermiEquiv_symm
import Mathlib
import Definitions.Def_ChapterFermionFock
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes FConf) :
    ((x : lpFiniteModes FConf) : FermiFock) = toLpF (fermiEquiv.symm x) := by

  rw [← coe_fermiEquiv, LinearEquiv.apply_symm_apply]
