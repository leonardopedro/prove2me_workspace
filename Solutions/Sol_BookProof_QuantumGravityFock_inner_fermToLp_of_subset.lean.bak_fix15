-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.inner_fermToLp_of_subset
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {u : FermAlg} {s : Finset FermConf} (hs : u.support ⊆ s)
    (v : FermAlg) :
    (inner ℂ (fermToLp u) (fermToLp v) : ℂ) = ∑ α ∈ s, (starRingEnd ℂ) (u α) * v α := by

  rw [lp.inner_eq_tsum]
  have hcoord : ∀ α : FermConf,
      (inner ℂ (((fermToLp u : FermFock) : FermConf → ℂ) α)
        (((fermToLp v : FermFock) : FermConf → ℂ) α) : ℂ)
        = (starRingEnd ℂ) (u α) * v α := by
    intro α
    simp [RCLike.inner_apply, mul_comm]
  rw [tsum_congr hcoord]
  refine tsum_eq_sum fun α hα => ?_
  have hu : u α = 0 := by
    by_contra hc
    exact hα (hs (Finsupp.mem_support_iff.mpr hc))
  rw [hu, map_zero, zero_mul]
