-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.dGamma_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_symmetricOn
import Theorems.Thm_BookProof_FockSecondQuantization_dGammaOp_quadForm_nonneg
import Theorems.Thm_BookProof_FockSecondQuantization_finiteOccupation_dense
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
open BookProof.FockSecondQuantization




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
_dense

theorem solution {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col)
    (hpos : IsPosCol col) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp :=
   col) A :=
    friedrichs_extension_exists
      ⟨lpFiniteModes Conf, dGammaOp col, dGammaOp_symmetricOn hherm,
        dGammaOp_quadForm_nonneg hpos⟩
      finiteOccupati
