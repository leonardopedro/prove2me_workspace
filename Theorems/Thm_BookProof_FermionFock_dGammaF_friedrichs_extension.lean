-- Generated from ChapterFermionFock.lean — theorem BookProof.FermionFock.dGammaF_friedrichs_extension
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FockSecondQuantization
open BookProof.SmCar
open BookProof.YangMillsFriedrichs
open BookProof.FermionFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

theorem BookProof.FermionFock.dGammaF_friedrichs_extension {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col)
    (hpos : IsPosCol col) :
    ∃ (Dom : Submodule ℂ FermiFock) (A : Dom →ₗ[ℂ] FermiFock),
      IsPositiveSelfAdjointExtension (dGammaOpF col) A := by sorry
