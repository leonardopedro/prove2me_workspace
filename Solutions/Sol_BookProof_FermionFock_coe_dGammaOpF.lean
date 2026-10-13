-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.coe_dGammaOpF
import Mathlib
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)
open BookProof.SmCar

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (x : lpFiniteModes FConf) :
    dGammaOpF col x = toLpF (dGammaF col (fermiEquiv.symm x)) := by

  simp [dGammaOpF, LinearEquiv.conj_apply, coe_fermiEquiv]
