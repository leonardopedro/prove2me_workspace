-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_creF_right
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_inner_creF_left
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
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
theorem solution (j : ℕ) (u v : FermiAlg) :
    (inner ℂ (toLpF u) (toLpF (creF j v)) : ℂ) = inner ℂ (toLpF (annF j u)) (toLpF v) := by

  have h := inner_creF_left j v u
  have := congrArg (starRingEnd ℂ) h
  rwa [inner_conj_symm, inner_conj_symm] at this
