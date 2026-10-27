-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaOpF_symmetricOn
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_coe_fermiEquiv_symm
import Theorems.Thm_BookProof_FermionFock_inner_dGammaF_symm
import Theorems.Thm_BookProof_FermionFock_coe_dGammaOpF
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) :
    SymmetricOn (lpFiniteModes FConf) (dGammaOpF col) := by

  intro x y
  rw [coe_dGammaOpF, coe_dGammaOpF, coe_fermiEquiv_symm x, coe_fermiEquiv_symm y]
  exact inner_dGammaF_symm hherm _ _
