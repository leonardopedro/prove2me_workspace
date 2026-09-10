-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.re_inner_dGamma_diagCol
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_dGamma_diagCol_apply
import Theorems.Thm_BookProof_FockOneParticleGap_conj_mul_re
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ → ℝ) (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re
      = ∑ α ∈ u.support, confEnergy e α * ‖u α‖ ^ 2 := by

  rw [inner_toLp u (dGamma (diagCol e) u), Complex.re_sum]
  refine Finset.sum_congr rfl fun α _ => ?_
  rw [dGamma_diagCol_apply,
    show (starRingEnd ℂ) (u α) * (((confEnergy e α : ℝ) : ℂ) * u α)
        = ((confEnergy e α : ℝ) : ℂ) * ((starRingEnd ℂ) (u α) * u α) by ring,
    Complex.re_ofReal_mul, conj_mul_re]
