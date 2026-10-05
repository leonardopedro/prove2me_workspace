-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaOpFB_symmetricOn
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_dGammaOpF_symmetricOn
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution {ε : ℕ ≃ FConf} {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) :
    SymmetricOn (finiteModeDomain (l2BasisN ε)) (dGammaOpFB ε col) := by

  intro x y
  exact dGammaOpF_symmetricOn hherm
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) x)
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) y)
