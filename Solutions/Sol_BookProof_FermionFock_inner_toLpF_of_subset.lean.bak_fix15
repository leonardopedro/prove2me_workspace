-- Generated from ChapterFermionFock.lean — solution of BookProof.FermionFock.inner_toLpF_of_subset
import Mathlib
import Definitions.Def_ChapterFermionFock
open BookProof.FermionFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

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
