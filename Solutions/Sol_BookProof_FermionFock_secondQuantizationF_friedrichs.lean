-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.secondQuantizationF_friedrichs
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_dGammaF_friedrichs_extension
import Theorems.Thm_BookProof_FockSecondQuantization_isHermCol_opCol
import Theorems.Thm_BookProof_FockSecondQuantization_isPosCol_opCol
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.SmCar

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (hA : SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp A))
    (hpos : ∀ x, 0 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    ∃ (Dom : Submodule ℂ FermiFock) (A' : Dom →ₗ[ℂ] FermiFock),
      IsPositiveSelfAdjointExtension (dGammaOpF (opCol b A)) A' := dGammaF_friedrichs_extension (isHermCol_opCol hA) (isPosCol_opCol hpos)
