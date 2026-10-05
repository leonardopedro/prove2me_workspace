-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.coe_dGammaOpF
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
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (x : lpFiniteModes FConf) :
    dGammaOpF col x = toLpF (dGammaF col (fermiEquiv.symm x)) := by

  simp [dGammaOpF, LinearEquiv.conj_apply, coe_fermiEquiv]
