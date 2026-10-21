-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.ainner_eq_sum
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {u : γ →₀ ℂ} {s : Finset γ} (hs : u.support ⊆ s) (v : γ →₀ ℂ) :
    ainner u v = ∑ g ∈ s, (starRingEnd ℂ) (u g) * v g := by

  rw [ainner, lp.inner_eq_tsum]
  have hcoord : ∀ g : γ,
      (inner ℂ (((toL2 u : L2I γ) : γ → ℂ) g) (((toL2 v : L2I γ) : γ → ℂ) g) : ℂ)
        = (starRingEnd ℂ) (u g) * v g := by
    intro g; simp [RCLike.inner_apply, mul_comm]
  rw [tsum_congr hcoord]
  refine tsum_eq_sum fun g hg => ?_
  have hu : u g = 0 := by
    by_contra hc
    exact hg (hs (Finsupp.mem_support_iff.mpr hc))
  rw [hu, map_zero, zero_mul]
