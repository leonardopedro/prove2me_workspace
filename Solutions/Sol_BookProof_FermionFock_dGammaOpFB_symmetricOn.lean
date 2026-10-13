-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaOpFB_symmetricOn
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_dGammaOpF_symmetricOn
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution {ε : ℕ ≃ FConf} {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) :
    SymmetricOn (finiteModeDomain (l2BasisN ε)) (dGammaOpFB ε col) := by

  intro x y
  exact dGammaOpF_symmetricOn hherm
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) x)
    (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε) y)
