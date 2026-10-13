-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaOpF_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_coe_fermiEquiv_symm
import Theorems.Thm_BookProof_FermionFock_inner_dGammaF_nonneg
import Theorems.Thm_BookProof_FermionFock_coe_dGammaOpF
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)
open BookProof.FockSecondQuantization
open BookProof.SmCar

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col)
    (x : lpFiniteModes FConf) : 0 ≤ quadForm (dGammaOpF col) x := by

  rw [quadForm, coe_dGammaOpF, coe_fermiEquiv_symm x]
  exact inner_dGammaF_nonneg hpos _
