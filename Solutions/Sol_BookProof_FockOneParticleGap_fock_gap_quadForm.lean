-- Generated from ChapterFockOneParticleGap.lean — solution of BookProof.FockOneParticleGap.fock_gap_quadForm
import Mathlib
import Definitions.Def_ChapterFockOneParticleGap
import Theorems.Thm_BookProof_FockOneParticleGap_le_confEnergy
import Theorems.Thm_BookProof_FockOneParticleGap_norm_toLp_sq
import Theorems.Thm_BookProof_FockOneParticleGap_re_inner_dGamma_diagCol
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFarisLavine
open BookProof.FockOneParticleGap













noncomputable section


open BookProof.FockSecondQuantization BookProof.FarisLavine BookProof.NavierStokesFlow
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {e : ℕ → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (he : ∀ k, mu ≤ e k)
    {u : FockAlg} (h0 : u 0 = 0) :
    mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma (diagCol e) u)) : ℂ).re := by

  rw [re_inner_dGamma_diagCol, norm_toLp_sq, Finset.mul_sum]
  refine Finset.sum_le_sum fun α hα => ?_
  have hα0 : α ≠ 0 := by
    rintro rfl
    exact (Finsupp.mem_support_iff.mp hα) h0
  exact mul_le_mul_of_nonneg_right (le_confEnergy hmu he hα0) (sq_nonneg ‖u α‖)
