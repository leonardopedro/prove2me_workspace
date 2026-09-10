-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.norm_toLp_sq
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_conj_mul_re
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (u : FockAlg) : ‖toLp u‖ ^ 2 = ∑ α ∈ u.support, ‖u α‖ ^ 2 := by

  have h1 : (inner ℂ (toLp u) (toLp u) : ℂ).re = ‖toLp u‖ ^ 2 := by
    rw [inner_self_eq_norm_sq_to_K]
    norm_cast
  rw [← h1, inner_toLp u u, Complex.re_sum]
  exact Finset.sum_congr rfl fun α _ => conj_mul_re (u α)
