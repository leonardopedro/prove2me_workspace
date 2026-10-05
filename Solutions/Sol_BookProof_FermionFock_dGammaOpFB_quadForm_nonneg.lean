-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaOpFB_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_dGammaOpF_quadForm_nonneg
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution {ε : ℕ ≃ FConf} {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col)
    (x : finiteModeDomain (l2BasisN ε)) : 0 ≤ quadForm (dGammaOpFB ε col) x :=
  dGammaOpF_quadForm_nonneg hpos
      (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) x)
