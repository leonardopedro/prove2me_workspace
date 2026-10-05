-- Generated from ChapterFermionFock.lean — theorem BookProof.FermionFock.inner_dGammaF_symm
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.FockSecondQuantization
open BookProof.SmCar
open BookProof.FermionFock



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

theorem BookProof.FermionFock.inner_dGammaF_symm {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) (u v : FermiAlg) :
    (inner ℂ (toLpF (dGammaF col u)) (toLpF v) : ℂ)
      = inner ℂ (toLpF u) (toLpF (dGammaF col v)) := by sorry
