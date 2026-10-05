-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.dGammaF_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_dGammaOpF_symmetricOn
import Theorems.Thm_BookProof_FermionFock_dGammaOpF_quadForm_nonneg
import Theorems.Thm_BookProof_FermionFock_finiteOccupationF_dense
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col)
    (hpos : IsPosCol col) :
    ∃ (Dom : Submodule ℂ FermiFock) (A : Dom →ₗ[ℂ] FermiFock),
      IsPositiveSelfAdjointExtension (dGammaOpF col) A :=
  friedrichs_extension_exists
      ⟨lpFiniteModes FConf, dGammaOpF col, dGammaOpF_symmetricOn hherm,
        dGammaOpF_quadForm_nonneg hpos⟩
      finiteOccupationF_dense
