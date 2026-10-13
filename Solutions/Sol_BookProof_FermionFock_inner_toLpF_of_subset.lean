-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_toLpF_of_subset
import Mathlib
import Definitions.Def_ChapterFermionFock
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
theorem solution {u : FermiAlg} {s : Finset FConf} (hs : u.support ⊆ s)
    (v : FermiAlg) :
    (inner ℂ (toLpF u) (toLpF v) : ℂ) = ∑ S ∈ s, (starRingEnd ℂ) (u S) * v S := by

  rw [lp.inner_eq_tsum]
  have hcoord : ∀ S : FConf,
      (inner ℂ (((toLpF u : FermiFock) : FConf → ℂ) S)
        (((toLpF v : FermiFock) : FConf → ℂ) S) : ℂ) = (starRingEnd ℂ) (u S) * v S := by
    intro S
    simp [RCLike.inner_apply, mul_comm]
  rw [tsum_congr hcoord]
  refine tsum_eq_sum fun S hS => ?_
  have hu : u S = 0 := by
    by_contra hc
    exact hS (hs (Finsupp.mem_support_iff.mpr hc))
  rw [hu, map_zero, zero_mul]
