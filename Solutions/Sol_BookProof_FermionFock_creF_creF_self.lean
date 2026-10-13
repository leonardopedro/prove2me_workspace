-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.creF_creF_self
import Mathlib
import Definitions.Def_ChapterFermionFock
import Theorems.Thm_BookProof_FermionFock_car_creF_creF
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (j : ℕ) (u : FermiAlg) : creF j (creF j u) = 0 := by

  have h := car_creF_creF j j u
  have h2 : (2 : ℂ) • creF j (creF j u) = 0 := by
    rw [two_smul]; exact h
  simpa using h2
