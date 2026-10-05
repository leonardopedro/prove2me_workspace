-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaOpF_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_coe_fermiEquiv_symm
import Theorems.Thm_BookProof_FermionFock_inner_dGammaF_nonneg
import Theorems.Thm_BookProof_FermionFock_coe_dGammaOpF
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col)
    (x : lpFiniteModes FConf) : 0 ≤ quadForm (dGammaOpF col) x := by

  rw [quadForm, coe_dGammaOpF, coe_fermiEquiv_symm x]
  exact inner_dGammaF_nonneg hpos _
